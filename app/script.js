document.body.onload = () => {
  const computeString = () => {
    let values = {};
    generator = document.getElementById("generator").value
    document.getElementById('target').querySelectorAll('[name]').forEach((element) => {
      switch (element.getAttribute('type')) {
        default:
          values[element.getAttribute('name')] = element.value;
          break;
      }
      let urlString = 'https://gitpod.io/#';
      Object.keys(values).forEach((key,i) => {
        if (i > 0) {
          urlString += ',';
        }
        urlString += encodeURIComponent(key)+'='+encodeURIComponent(values[key]);
      });
      urlString += ",/" +generator
      const link = document.getElementById('computedUrl');
      link.setAttribute('href', urlString);
      // link.textContent = urlString;
    })
  }
  document.getElementById('target').querySelectorAll('[name]').forEach((element) => {
    element.addEventListener('focus', (e) => {
      computeString();
    })
  })
}