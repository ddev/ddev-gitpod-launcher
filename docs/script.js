// Function to compute and update the URL based on form inputs
const computeLink = () => {
  // Initialize an object to store the form values
  let values = {};
  // Get the form element with id 'target'
  const targetElement = document.getElementById('target');
  // If the target element exists, iterate over its children with a 'name' attribute
  if (targetElement) {
    targetElement.querySelectorAll('[name]').forEach((element) => {
      // Store each element's value in the values object using its name attribute as the key
      values[element.getAttribute('name')] = element.value;
    });
  }

  // Start building the URL string with the base Gitpod URL and autostart parameter
  let urlString = 'https://gitpod.io/?autostart=true#';
  // Extract the keys from the values object
  const keys = Object.keys(values);
  // Append each key-value pair to the URL string, URL-encoded and separated by commas
  keys.forEach((key, i) => {
    urlString += (i > 0 ? ',' : '') + encodeURIComponent(key) + '=' + encodeURIComponent(values[key]);
  });

  // Extract the owner from the current window's hostname
  const owner = window.location.host.split('.')[0];
  // Construct the base repository URL using the owner and the current pathname
  const baseRepo = `https://github.com/${owner}${window.location.pathname}`;
  // Append the base repository URL to the urlString
  urlString += '/' + baseRepo;

  // Get the elements where the computed URL will be displayed
  const computedUrlElement = document.getElementById('computedUrl');
  const ddevLinkElement = document.getElementById('ddev-link');
  // If both elements exist, set the href attribute and text content to the computed URL
  if (computedUrlElement && ddevLinkElement) {
    computedUrlElement.setAttribute('href', urlString);
    ddevLinkElement.textContent = urlString; // Use textContent for security and performance
  }
};

// Call the computeLink function to initialize the URL link on page load
computeLink();

// Add input event listeners to all form elements with a 'name' attribute within the element with id 'target'
const targetElement = document.getElementById('target');
// If the target element exists, attach the computeLink function as an event listener for the 'input' event
if (targetElement) {
  targetElement.querySelectorAll('[name]').forEach((element) => {
    element.addEventListener('input', computeLink);
  });
}

// Add input event listener to the repository field to update artifacts when it changes
const repoElement = document.getElementById('ddev-repo');
// If the repository element exists, attach the updateArtifacts function as an event listener for the 'input' event
if (repoElement) {
  repoElement.addEventListener('input', updateArtifacts);
}