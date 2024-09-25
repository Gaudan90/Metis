// Importa Instascan per la scansione del QR code
document.addEventListener('DOMContentLoaded', function () {
    const scanner = new Instascan.Scanner({ video: document.getElementById('preview') });
    scanner.addListener('scan', function (content) {
        alert('Scanned content: ' + content);
        // Aggiungi logica per salvare i dati della scansione se necessario
    });

    document.getElementById('scanBtn').addEventListener('click', function () {
        // Mostra l'elemento del video scanner
        document.getElementById('scanner').style.display = 'block';

        Instascan.Camera.getCameras().then(function (cameras) {
            if (cameras.length > 0) {
                scanner.start(cameras[0]);
            } else {
                console.error('No cameras found.');
            }
        }).catch(function (e) {
            console.error(e);
        });
    });

    const showRecentBtn = document.getElementById('showRecentBtn');
    const recentMachines = document.getElementById('recentMachines');

    showRecentBtn.addEventListener('click', function () {
        recentMachines.style.display = recentMachines.style.display === 'none' ? 'block' : 'none';
        loadRecentMachines();
    });

    function loadRecentMachines() {
        // Simula il caricamento di macchine recenti/salvate
        const machines = [
            { id: 1, name: 'Machine 1', description: 'Description of Machine 1' },
            { id: 2, name: 'Machine 2', description: 'Description of Machine 2' },
            { id: 3, name: 'Machine 3', description: 'Description of Machine 3' }
        ];

        const machinesList = document.getElementById('machinesList');
        machinesList.innerHTML = '';

        machines.forEach(machine => {
            const machineItem = document.createElement('div');
            machineItem.classList.add('machine-item');
            machineItem.innerHTML = `<h3>${machine.name}</h3><p>${machine.description}</p>`;
            machinesList.appendChild(machineItem);
        });
    }
});
