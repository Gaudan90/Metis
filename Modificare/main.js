// Definisci l'oggetto descriptions all'inizio del file
const descriptions = {
  IT: "Rapidità nello scioglimento e nella tempera del cioccolato. Misure d'ingombro minime. Tavola vibrante riscaldata in bassa tensione. Pulizia facilitata della macchina. Dosatore volumetrico, pedaliera per il controllo del flusso del cioccolato. Gruppo refrigerante a circuito chiusocon scambiatore in controcorrente.",
  EN: "Quick melting and tempering of chocolate. Minimal overall dimensions. Low-voltage heated vibrating table. Easy cleaning of the machine. Volumetric dispenser, foot pedal for controlling the chocolate flow. Closed-circuit cooling system with counter-current heat exchanger.",
  SP: "Rapidez en la fusión y templado del chocolate. Dimensiones generales mínimas. Mesa vibratoria calentada de baja tensión. Limpieza facilitada de la máquina. Dosificador volumétrico, pedal para controlar el flujo de chocolate. Sistema de refrigeración de circuito cerrado con intercambiador de calor en contracorriente.",
  FR: "Rapidité dans la fonte et le tempérage du chocolat. Dimensions globales minimales. Table vibrante chauffée en basse tension. Nettoyage facilité de la machine. Doseur volumétrique, pédale pour contrôler le flux de chocolat.Système de réfrigération en circuit fermé avec échangeur de chaleur à contre-courant.",
  CN: "巧克力快速融化和回火。 最小占地尺寸。 低电压加热振动台。机器易于清洁。 容积式分配器，脚踏控制巧克力流量。闭路冷却系统，带逆流热交换器",
  RU: "Быстрое плавление и темперирование шоколада. Минимальные габариты. Низковольтный подогреваемый вибрационный стол. Облегченная чистка машины. Объемный дозатор, ножной педальный контроль потока шоколада. Охладительная система замкнутого контура с противоточным теплообменником.",
};

function updateDescription() {
  const language = document.getElementById("language").value;
  const descriptionElement = document.getElementById("description");
  descriptionElement.textContent =
    descriptions[language] || "Descrizione non disponibile";
}

// Aggiungi un event listener per quando il DOM è completamente caricato
document.addEventListener("DOMContentLoaded", function () {
  const languageSelect = document.getElementById("language");
  if (languageSelect) {
    languageSelect.addEventListener("change", updateDescription);
    // Imposta la descrizione iniziale
    updateDescription();
  } else {
    console.error("Elemento select con id 'language' non trovato");
  }
});
