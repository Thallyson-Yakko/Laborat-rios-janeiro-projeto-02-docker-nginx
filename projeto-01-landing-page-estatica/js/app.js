// Lead form handler
document.getElementById('leadForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = this.querySelector('input[type="email"]').value;
    
    // Simulate API call
    const btn = this.querySelector('button');
    const originalText = btn.textContent;
    
    btn.textContent = 'Processando...';
    btn.disabled = true;
    
    setTimeout(() => {
        alert(`Obrigado! Enviamos um e-mail para ${email} com seu acesso gratuito.`);
        btn.textContent = originalText;
        btn.disabled = false;
        this.reset();
    }, 2000);
});

// Smooth scroll for navigation
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Header background on scroll
window.addEventListener('scroll', () => {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(255,255,255,0.98)';
    } else {
        header.style.background = 'rgba(255,255,255,0.95)';
    }
});

// Performance monitoring
if ('performance' in window) {
    window.addEventListener('load', () => {
        setTimeout(() => {
            const perfData = performance.getEntriesByType('navigation')[0];
            console.log('Page Load Time:', perfData.loadEventEnd - perfData.fetchStart, 'ms');
        }, 0);
    });
}
