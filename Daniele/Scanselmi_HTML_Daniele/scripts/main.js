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

    function toggleSidebar() {
        sidebar.classList.toggle('active');
        menuToggle.classList.toggle('arrow-left');
        menuToggle.classList.toggle('arrow-right');
        if (sidebar.classList.contains('active')) {
            menuToggle.style.left = '200px';
        } else {
            menuToggle.style.left = '0';
        }
    }

    function resetView() {
        sidebar.classList.remove('active');
        menuToggle.classList.remove('arrow-left');
        menuToggle.classList.add('arrow-right');
        menuToggle.style.left = '0';
        resetFooterAndMachineList();
    }

    function handleTouchStart(e) {
        startY = e.touches[0].clientY;
        isFooterDragging = e.target === footer || footer.contains(e.target);
    }

    function handleTouchMove(e) {
        if (!startY) return;
        currentY = e.touches[0].clientY;
        let deltaY = startY - currentY;
        
        if (isFooterDragging) {
            e.preventDefault();
            let newTransform = Math.max(-window.innerHeight + 60, -deltaY);
            footer.style.transform = `translateY(${newTransform}px)`;
            machineList.style.transform = `translateY(calc(100% + ${newTransform}px))`;
        }
    }

    function handleTouchEnd() {
        if (!startY || !currentY) return;
        let deltaY = startY - currentY;
        
        if (isFooterDragging) {
            if (deltaY > 100) {
                footer.style.transform = 'translateY(-100%)';
                machineList.classList.add('active');
            } else {
                footer.style.transform = 'translateY(0)';
                machineList.classList.remove('active');
            }
        }
        
        resetDragState();
    }

    function resetDragState() {
        isFooterDragging = false;
        startY = null;
        currentY = null;
    }

    function resetFooterAndMachineList() {
        machineList.classList.remove('active');
        footer.style.transform = 'translateY(0)';
        machineList.style.transform = 'translateY(100%)';
    }

    function handleResize() {
        if (!machineList.classList.contains('active')) {
            machineList.style.transform = 'translateY(100%)';
        }
    }

    function onScanSuccess(decodedText, decodedResult) {
        console.log(`Code matched = ${decodedText}`, decodedResult);
        showLoadingAnimation();
    }

    function onScanFailure(error) {
        console.warn(`Code scan error = ${error}`);
    }

    function showLoadingAnimation() {
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

    function initQRScanner() {
        Html5Qrcode.getCameras().then(devices => {
            if (devices && devices.length) {
                let html5QrcodeScanner = new Html5Qrcode("qr-reader");
                const qrConfig = { fps: 10, qrbox: { width: 250, height: 250 } };
                html5QrcodeScanner.start({ facingMode: "environment" }, qrConfig, onScanSuccess, onScanFailure)
                    .catch(err => {
                        console.error("Error starting QR scanner:", err);
                    });
            }
        }).catch(err => {
            console.error("Error getting cameras:", err);
        });
    }

    window.addEventListener('resize', handleResize);
    menuToggle.addEventListener('click', toggleSidebar);
    document.querySelector('.home-link').addEventListener('click', resetView);
    footer.addEventListener('touchstart', handleTouchStart);
    footer.addEventListener('touchmove', handleTouchMove);
    footer.addEventListener('touchend', handleTouchEnd);
    machineList.addEventListener('touchstart', handleTouchStart);
    machineList.addEventListener('touchmove', handleTouchMove);
    machineList.addEventListener('touchend', handleTouchEnd);

    // Initialize QR scanner
    initQRScanner();
});