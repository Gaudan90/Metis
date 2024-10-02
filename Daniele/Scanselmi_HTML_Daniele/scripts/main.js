document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const footer = document.querySelector('footer');
    const popup = document.getElementById('popup');
    const loadingBar = document.getElementById('loading-bar');
    const machineList = document.getElementById('machine-list');

    let startY, currentY;
    let isFooterDragging = false;
    let footerHeight = footer.offsetHeight;
    let isDragging = false;
    let startY, currentY;

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
        machineList.classList.remove('active');
        footer.style.transform = 'translateY(0)';
    }

    function handleTouchStart(e) {
        isDragging = true;
        startY = e.touches[0].clientY;
        footer.style.transition = 'none';
    }

    function handleTouchMove(e) {
        if (!isDragging) return;
        currentY = e.touches[0].clientY;
        let deltaY = startY - currentY;
        
        if (deltaY > 0) {
            // Trascinamento verso l'alto
            let newPosition = Math.min(deltaY, window.innerHeight - footerHeight);
            footer.style.transform = `translateY(-${newPosition}px)`;
            machineList.style.bottom = `${newPosition}px`;
        } else {
            // Trascinamento verso il basso
            let newPosition = Math.max(0, -deltaY);
            footer.style.transform = `translateY(-${window.innerHeight - footerHeight - newPosition}px)`;
            machineList.style.bottom = `${window.innerHeight - footerHeight - newPosition}px`;
        }
    }

    function handleTouchEnd() {
        if (!isDragging) return;
        isDragging = false;
        footer.style.transition = 'transform 0.3s ease-in-out';
        
        let deltaY = startY - currentY;
        if (Math.abs(deltaY) > 100) {
            if (deltaY > 0) {
                // Apri completamente
                footer.style.transform = `translateY(-${window.innerHeight - footerHeight}px)`;
                machineList.style.bottom = '0';
                machineList.classList.add('active');
            } else {
                // Chiudi completamente
                footer.style.transform = 'translateY(0)';
                machineList.style.bottom = `-${window.innerHeight - footerHeight}px`;
                machineList.classList.remove('active');
            }
        } else {
            // Torna alla posizione originale
            footer.style.transform = 'translateY(0)';
            machineList.style.bottom = `-${window.innerHeight - footerHeight}px`;
            machineList.classList.remove('active');
        }
    }

    function handleFooterDrag(deltaY) {
        if (deltaY > 0 && deltaY < window.innerHeight - 60) {
            machineList.style.bottom = `${deltaY}px`;
            footer.style.transform = `translateY(-${deltaY}px)`;
        }
    }

    function handleMachineListDrag(deltaY) {
        if (deltaY < 0 && Math.abs(deltaY) < window.innerHeight - 60) {
            machineList.style.bottom = `${window.innerHeight - 60 + deltaY}px`;
            footer.style.transform = `translateY(-${window.innerHeight - 60 + deltaY}px)`;
        }
    }

    function finalizeFooterDrag(deltaY) {
        if (deltaY > 100) {
            machineList.classList.add('active');
            footer.style.transform = 'translateY(-100%)';
        } else {
            machineList.classList.remove('active');
            footer.style.transform = 'translateY(0)';
        }
    }

    function finalizeMachineListDrag(deltaY) {
        if (deltaY < -100) {
            machineList.classList.remove('active');
            footer.style.transform = 'translateY(0)';
        } else {
            machineList.classList.add('active');
            footer.style.transform = 'translateY(-100%)';
        }
    }

    function resetDragState() {
        machineList.style.bottom = '';
        isFooterDragging = false;
        startY = null;
        currentY = null;
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

    async function initializeQRScanner() {
        try {
            // Request camera permission
            await navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } });
            
            const html5QrCode = new Html5Qrcode("qr-reader");
            const config = { fps: 10, qrbox: { width: 250, height: 250 } };
            
            html5QrCode.start({ facingMode: "environment" }, config, onScanSuccess, onScanFailure);
        } catch (err) {
            console.error("Error in accessing camera:", err);
            alert("Unable to access the camera. Please ensure you've granted the necessary permissions.");
        }
    }

    menuToggle.addEventListener('click', toggleSidebar);
    document.querySelector('.home-link').addEventListener('click', resetView);
    footer.addEventListener('touchstart', handleTouchStart);
    footer.addEventListener('touchmove', handleTouchMove);
    footer.addEventListener('touchend', handleTouchEnd);
    machineList.addEventListener('touchstart', handleTouchStart);
    machineList.addEventListener('touchmove', handleTouchMove);
    machineList.addEventListener('touchend', handleTouchEnd);

    initializeQRScanner();
});