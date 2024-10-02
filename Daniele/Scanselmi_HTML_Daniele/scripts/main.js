document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const main = document.querySelector('main');
    const footer = document.querySelector('footer');
    const popup = document.getElementById('popup');
    const loadingBar = document.getElementById('loading-bar');
    const machineList = document.getElementById('machine-list');

    let startY, currentY;
    let isFooterDragging = false;

    menuToggle.addEventListener('click', function() {
        sidebar.classList.toggle('active');
        menuToggle.classList.toggle('arrow-left');
        menuToggle.classList.toggle('arrow-right');
    });

    footer.addEventListener('touchstart', function(e) {
        startY = e.touches[0].clientY;
        isFooterDragging = true;
    });

    footer.addEventListener('touchmove', function(e) {
        if (!isFooterDragging) return;
        currentY = e.touches[0].clientY;
        let deltaY = startY - currentY;
        if (deltaY > 0 && deltaY < window.innerHeight - 60) {
            machineList.style.bottom = `${deltaY}px`;
            footer.style.transform = `translateY(-${deltaY}px)`;
        }
    });

    footer.addEventListener('touchend', function() {
        isFooterDragging = false;
        if (currentY && startY - currentY > 100) {
            machineList.classList.add('active');
            footer.style.transform = 'translateY(-100%)';
        } else {
            machineList.classList.remove('active');
            footer.style.transform = 'translateY(0)';
        }
        machineList.style.bottom = '';
        startY = null;
        currentY = null;
    });

    machineList.addEventListener('touchstart', function(e) {
        startY = e.touches[0].clientY;
    });

    machineList.addEventListener('touchmove', function(e) {
        currentY = e.touches[0].clientY;
        let deltaY = currentY - startY;
        if (deltaY > 0 && deltaY < window.innerHeight - 60) {
            machineList.style.bottom = `${window.innerHeight - 60 - deltaY}px`;
            footer.style.transform = `translateY(-${window.innerHeight - 60 - deltaY}px)`;
        }
    });

    machineList.addEventListener('touchend', function() {
        if (currentY && currentY - startY > 100) {
            machineList.classList.remove('active');
            footer.style.transform = 'translateY(0)';
        } else {
            machineList.classList.add('active');
            footer.style.transform = 'translateY(-100%)';
        }
        machineList.style.bottom = '';
        startY = null;
        currentY = null;
    });

    function onScanSuccess(decodedText, decodedResult) {
        console.log(`Code matched = ${decodedText}`, decodedResult);
        
        popup.style.display = 'block';
        let width = 0;
        const interval = setInterval(() => {
            if (width >= 100) {
                clearInterval(interval);
                loadingBar.style.width = '100%';
                popup.querySelector('p').textContent = 'Download completed';
                setTimeout(() => {
                    popup.style.display = 'none';
                    loadingBar.style.width = '0%';
                }, 2000);
            } else {
                width += 10;
                loadingBar.style.width = width + '%';
            }
        }, 100);
    }

    function onScanFailure(error) {
        console.warn(`Code scan error = ${error}`);
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-reader",
        { fps: 10, qrbox: {width: 250, height: 250} },
        /* verbose= */ false);
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);
});