
function setClass(id,classname)
{
  var el = document.getElementById(id);
  el.className = classname; //(classname == el.className)?prev:
  tools.setFocus(classname);
  return false;
}

//tools
var tools = 
{
  isNumber:function(number)
  {
    return  /^-?\d+$/.test(number);
  },
  inArray:function(value, values)
  {
    for (var i=0; i<values.length; i++) 
    {
      if(values[i] == value) return true;
    }  
    return false;
  },
  
  initXML:function(xmlString) 
  {
    if(window.DOMParser) //Mozilla
    {
      var parser = new DOMParser();
      var xml = parser.parseFromString(xmlString,'text/xml');
    }
    else //IE
    {
      var xml = new ActiveXObject('Msxml.DOMDocument');
      xml.async = false;
      xml.loadXML(xmlString);
    }
    return xml;
  },
    
  xmlStr:function(xml)
  { 
      if(window.XMLSerializer)
      {
        var serializer = new XMLSerializer();
        var xmlstr = serializer.serializeToString(xml);
        alert(xmlstr);
      }
      else
        alert(xml.xml);
  },
  
  //convert a string to an element
  getElement:function(html)
  {
    if(html == "") return new Array();
    var div = document.createElement('div');
    div.innerHTML = html;
    return div.childNodes[0];
  },
  
  //sets focus on a form element
  setFocus:function(id)
  {
    if(document.getElementById(id+"-focus"))
    {
      try{ document.getElementById(id+"-focus").focus(); }catch(e){}
    }
  },
  
  checkForm:function(form)
  {
    var warnedels = [];
    for (var i=0; i<form.elements.length; i++) 
    {
      var el = form.elements[i];    
      //clear
      el.className = el.className.replace(' required','');
      if(el.getAttribute('check'))
      {
        switch(el.nodeName.toLowerCase())
        {
          case 'input':
          case 'textarea':
            if(el.value == '')
            {
              el.className += ' required';
              warnedels.push(el);
            }
          break;
          case 'select':
            if(el.value == el.getAttribute("default") && el.getAttribute("default"))  
            {
              el.className += ' required';
              warnedels.push(el);
            }
          break
        }
      }
    }    
    return (warnedels.length == 0)?true:false;
  }
}





//javascript extensions
Function.prototype.getName = function ()
{
  return ("" + this).match(/function\s*([^(\s]*)/)[1];
};

Function.prototype.addMethods = function ()
{
  for (var i = 0; i < arguments.length; i++)
  {
    var name = arguments[i].getName();
    this.prototype[name] = arguments[i];

    window[name] = undefined;
  }
};

// check for XPath implementation 
if( document.implementation.hasFeature("XPath", "3.0") ) 
{ 
  // prototying the XMLDocument 
  XMLDocument.prototype.selectNodes = function(cXPathString, xNode) 
  { 
    if( !xNode ) { xNode = this; }
    var oNSResolver = this.createNSResolver(this.documentElement) 
    var aItems = this.evaluate(cXPathString, xNode, oNSResolver,
    XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null) 
    var aResult = [];
    for( var i = 0; i < aItems.snapshotLength; i++) 
      aResult[i] = aItems.snapshotItem(i);
    return aResult;
  } 

  // prototying the Element 
  Element.prototype.selectNodes = function(cXPathString) 
  { 
    if(this.ownerDocument.selectNodes) 
      return this.ownerDocument.selectNodes(cXPathString, this);
    else
      throw "For XML Elements Only";
  } 

  //prototying the XMLDocument 
  XMLDocument.prototype.selectSingleNode = function(cXPathString, xNode) 
  { 
    if( !xNode ) { xNode = this; }
    var xItems = this.selectNodes(cXPathString, xNode);
    if( xItems.length > 0 ) 
      return xItems[0];
    else 
      return null;
  } 
  
  // prototying the Element 
  Element.prototype.selectSingleNode = function(cXPathString) 
  {
    if(this.ownerDocument.selectSingleNode) 
      return this.ownerDocument.selectSingleNode(cXPathString, this);
    else
      throw "For XML Elements Only"; 
  } 
} 
