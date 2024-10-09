// Get form elements
const yearSelect = document.getElementById("year");
const languageSelect = document.getElementById("language");
const submitButton = document.getElementById("button");

// Add click event listener to the submit button
submitButton.addEventListener("click", function (event) {
  event.preventDefault();

  // Get selected values
  const selectedYear = yearSelect.value;
  const selectedLanguage = languageSelect.value;

  // Create an object with the form data
  const formData = {
    year: selectedYear,
    language: selectedLanguage,
  };

  // Convert the object to a JSON string
  const jsonData = JSON.stringify(formData);

  // Store the data in localStorage
  localStorage.setItem("formData", jsonData);

  // Redirect to the results page
  window.location.href = "results.html";
});
