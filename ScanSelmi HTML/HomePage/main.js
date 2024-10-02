document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const main = document.querySelector('main');
    const footer = document.querySelector('footer');
    const popup = document.getElementById('popup');
    const loadingBar = document.getElementById('loading-bar');

    menuToggle.addEventListener('click', function() {
        sidebar.classList.toggle('active');
        main.classList.toggle('shift');
    });

    footer.addEventListener('click', function() {
        alert('You clicked the footer!');
    });

    function onScanSuccess(decodedText, decodedResult) {
        // Handle the scanned code as you like, for now, just console.log the result
        console.log(`Code matched = ${decodedText}`, decodedResult);
        
        // Show loading bar
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
        // handle scan failure, usually better to ignore and keep scanning.
        console.warn(`Code scan error = ${error}`);
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-reader",
        { fps: 10, qrbox: {width: 250, height: 250} },
        /* verbose= */ false);
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);
});