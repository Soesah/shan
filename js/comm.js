function Comm()
{
}

var xmlhttp = null;
var focusel = null;
var activeDialogs = [];

Comm.addMethods(

  function init() {
  },

  function go(href) {
    document.location.href = href;
    return false;
  },

  function openDialog(form, id) {
    var holder = document.getElementById(id + "_holder");
    this.closeDialogs(null, true);
    activeDialogs.push(id);
    if (holder) {
      holder.className = 'show';
      tools.setFocus(id);
    }
    else {
      var xml = tools.initXML("<" + id + " action='" + form.getAttribute("href", 2) + "'/>");
      this.send("/comm/post.aspx", xml);
    }
    return false;
  },

  function closeDialogs(persistant, bubble) {
    for (var i = 0; i < activeDialogs.length; i++) {
      if (persistant)
        document.getElementById(activeDialogs[i] + "_holder").parentNode.removeChild(document.getElementById(activeDialogs[i] + "_holder"));
      else
        document.getElementById(activeDialogs[i] + "_holder").className = 'hide';

    }
    activeDialogs = [];
    //blur the focus
    //if(!bubble)
    //  blur();
    //allow resets of forms to continue
    return !persistant;
  },

  function sendForm(form, noreset) {
    if (!tools.checkForm(form)) return false;
    var xml = tools.initXML("<" + form.className + "/>");
    var action = form.getAttribute('action');
    var method = form.getAttribute('method');
    action += (method == "get") ? "?" : "";

    for (var i = 0; i < form.elements.length; i++) {
      var el = form.elements[i];
      if (el.tagName.toLowerCase() == 'button' || el.value == "") continue;

      if (method == "get")
        action += el.name + "=" + el.value + "&";

      var node = xml.createElement(el.name);
      node.appendChild(xml.createTextNode(el.value));

      xml.documentElement.appendChild(node);
    }
    this.send(action.substring(0, action.length - 1), xml, method);
    if (!noreset)
      form.reset();
    return false;
  },

//send the xml to the server
  function send(href, xml, method, async) {
    //if(xml)
    //alert("sending:("+href+")\n"+xml.xml);
    if (!method)
      method = "post"
    if (typeof (async) == 'undefined')
      async = true;

    if (window.XMLHttpRequest) //Mozilla, etc.
      xmlhttp = new XMLHttpRequest();
    else if (window.ActiveXObject) //IE5, 6
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

    if (xmlhttp != null) {
      var me = this;
      xmlhttp.onreadystatechange = function() { me.handleResponse(me); };
      xmlhttp.open(method, href, async)
      if (!xml)
        xml = tools.initXML("<dummy/>");

      xmlhttp.send(xml);

      if (!async)
        return xmlhttp.responseText;
    }
    else {
      this.disabled = true;
    }
    return false;
  },

  function handleResponse(me) {
    if (xmlhttp.readyState == 4) //loaded
    {
      var response = xmlhttp.responseText;

      //alert(response);
      if (response != '') {
        if (response.indexOf("<div") != -1) {
          var element = tools.getElement(xmlhttp.responseText);
          var id = element.getAttribute("id");
          if (id == "children") // a collection of elements
          {
            while (element.childNodes) {
              var child = element.childNodes[0];
              if (typeof (child) == "undefined") break;
              if (child.nodeType == 1)
                me.handleElements(child, child.getAttribute("id"));
              else
                element.removeChild(child);
            }
          }
          else if (id == "script") //script lines
          {
            while (element.childNodes) {
              var child = element.childNodes[0];
              if (typeof (child) == "undefined") break;
              if (child.nodeType == 1) {
                eval(child.textContent);
                element.removeChild(child);
              }
              else
                element.removeChild(child);
            }
          }
          else // a single element
            me.handleElements(element, id);

          tools.setFocus(id.substring(0, id.indexOf("_")));

        }
        else {
          
		  //var w = window.open();
          //w.document.write(response);
        }
      }
    }
  },

  function handleElements(element, id) {
    if (document.getElementById(id))                   //replace it if it exists
      document.getElementById(id).parentNode.replaceChild(element, document.getElementById(id));
    else if (element.getAttribute("pass") == "true")   //pass it if it only belongs somewhere specific
      element.parentNode.removeChild(element);
    else                                              //otherwise attach it to the body
      document.body.appendChild(element);
  }
)

var comm = new Comm();

if (window.addEventListener) //Mozilla, etc.
    window.addEventListener("load",function(){comm.init();},false);
else if (window.attachEvent) //IE
    window.attachEvent("onload",function(){comm.init();});
