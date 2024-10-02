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
        machineList.classList.remove('active');
        footer.style.transform = 'translateY(0)';
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
            handleFooterDrag(deltaY);
        } else {
            handleMachineListDrag(deltaY);
        }
    }

    function handleTouchEnd() {
        if (!startY || !currentY) return;
        let deltaY = startY - currentY;
        if (isFooterDragging) {
            finalizeFooterDrag(deltaY);
        } else {
            finalizeMachineListDrag(deltaY);
        }
        resetDragState();
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

    menuToggle.addEventListener('click', toggleSidebar);
    document.querySelector('.home-link').addEventListener('click', resetView);
    footer.addEventListener('touchstart', handleTouchStart);
    footer.addEventListener('touchmove', handleTouchMove);
    footer.addEventListener('touchend', handleTouchEnd);
    machineList.addEventListener('touchstart', handleTouchStart);
    machineList.addEventListener('touchmove', handleTouchMove);
    machineList.addEventListener('touchend', handleTouchEnd);

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-reader",
        { fps: 10, qrbox: {width: 250, height: 250} },
        /* verbose= */ false);
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);
});