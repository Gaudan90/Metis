document.addEventListener('DOMContentLoaded', function () {
    const scanner = new Instascan.Scanner({ video: document.getElementById('preview') });
    scanner.addListener('scan', function (content) {
        alert('Scanned content: ' + content);
    });

    document.getElementById('scanBtn').addEventListener('click', function () {
        document.getElementById('scanner').style.display = 'block';

        Instascan.Camera.getCameras().then(function (cameras) {
            if (cameras.length > 0) {
                scanner.start(cameras[0]).catch(err => {
                    console.error('Error starting scanner: ', err);
                    alert('Errore nell\'avviare lo scanner.');
                });
            } else {
                alert('Nessuna fotocamera trovata.');
            }
        }).catch(function (e) {
            console.error('Error accessing cameras: ', e);
            alert('Errore nell\'accesso alla fotocamera.');
        });
    });

    const showRecentBtn = document.getElementById('showRecentBtn');
    const recentMachines = document.getElementById('recentMachines');

    showRecentBtn.addEventListener('click', function () {
        if (recentMachines.style.display === 'none' || recentMachines.style.display === '') {
            recentMachines.style.display = 'block';
            loadRecentMachines();
        } else {
            recentMachines.style.display = 'none';
        }
    });

    function loadRecentMachines() {
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
