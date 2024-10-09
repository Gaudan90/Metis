function handleSignIn() {
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  const errorMessage = document.getElementById("error-message");

  if (email === "" || password === "") {
    errorMessage.textContent = "Please fill in all fields";
    errorMessage.style.display = "block"; // Mostra il messaggio di errore
    return;
  }

  // Rimuove il messaggio di errore se i campi sono validi
  errorMessage.style.display = "none";

  // Simula un'azione di login
  console.log("Email:", email);
  console.log("Password:", password);
  location.href = "../HomePage/index.html";
}
function goBack() {
  history.back(); // Torna alla pagina precedente
}
