document.body.onload = () => {
  const computeLink = () => {
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
      
      document.getElementById('computedUrl').setAttribute('href', urlString);
      document.getElementById('ddev-link').innerHTML = urlString;
    })
  }
  const updateArtifacts = () => {
    sourceField = document.getElementById("ddev-repo")
    artifactsField = document.getElementById("ddev-artifacts")
    artifactsField.value = sourceField.value + "-artifacts"
  }
  updateArtifacts();
  computeLink();
  document.getElementById('target').querySelectorAll('[name]').forEach((element) => {
    element.addEventListener('change', (e) => {
      computeLink();
    })
  })
  document.getElementById('ddev-repo').addEventListener('change', (e) => {
      updateArtifacts();
      computeLink();
    })

}
