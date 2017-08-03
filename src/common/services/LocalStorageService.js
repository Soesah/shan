class LocalStorageService {
  constructor() {}

  store(name, value) {
    localStorage.setItem(name, JSON.stringify(value));
  }

  has(name) {
    return this.get(name) !== null;
  }

  get(name) {
    return JSON.parse(localStorage.getItem(name));
  }

  delete(name) {
    return localStorage.removeItem(name);
  }
}