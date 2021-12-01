document.body.onload = () => {
  const computeString = () => {
    let values = {};
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
      
      
      const owner = window.location.host.split('.')[0]
      const baseRepo = `https://github.com/` + owner + window.location.pathname
      urlString += "/" + baseRepo
      
      const link = document.getElementById('computedUrl');
      link.setAttribute('href', urlString);
      // link.textContent = urlString;
    })
  }
  computeString();
  document.getElementById('target').querySelectorAll('[name]').forEach((element) => {
    element.addEventListener('change', (e) => {
      computeString();
    })
  })
}
