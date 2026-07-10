document.addEventListener('DOMContentLoaded', () => {
  initTabNavigation();
  initMobileMenu();
  initMapActions();
  initImageZoom();
});

function initTabNavigation() {
  const desktopButtons = document.querySelectorAll('.tab-btn');
  const mobileButtons = document.querySelectorAll('.mobile-tab-btn');
  const panels = document.querySelectorAll('.tab-panel');
  
  function switchTab(targetId) {
    desktopButtons.forEach(btn => {
      if (btn.getAttribute('data-target') === targetId) {
        btn.classList.add('active');
      } else {
        btn.classList.remove('active');
      }
    });

    mobileButtons.forEach(btn => {
      if (btn.getAttribute('data-target') === targetId) {
        btn.classList.add('active');
      } else {
        btn.classList.remove('active');
      }
    });

    panels.forEach(panel => {
      if (panel.id === targetId) {
        panel.style.display = 'block';
        void panel.offsetWidth;
        panel.classList.add('active');
      } else {
        panel.classList.remove('active');
        panel.style.display = 'none';
      }
    });

    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }

  desktopButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const target = btn.getAttribute('data-target');
      switchTab(target);
    });
  });

  const logoArea = document.querySelector('.logo-area');
  if (logoArea) {
    logoArea.addEventListener('click', () => {
      switchTab('home-tab');
    });
  }

  mobileButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const target = btn.getAttribute('data-target');
      switchTab(target);
      
      const drawer = document.getElementById('mobile-menu-drawer');
      const toggleBtn = document.getElementById('menu-toggle-btn');
      if (drawer.classList.contains('open')) {
        drawer.classList.remove('open');
        toggleBtn.classList.remove('open');
      }
    });
  });
}

function initMobileMenu() {
  const toggleBtn = document.getElementById('menu-toggle-btn');
  const drawer = document.getElementById('mobile-menu-drawer');

  if (toggleBtn && drawer) {
    toggleBtn.addEventListener('click', () => {
      const isOpen = drawer.classList.contains('open');
      if (isOpen) {
        drawer.classList.remove('open');
        toggleBtn.classList.remove('open');
      } else {
        drawer.classList.add('open');
        toggleBtn.classList.add('open');
      }
    });

    document.addEventListener('click', (e) => {
      if (!drawer.contains(e.target) && !toggleBtn.contains(e.target) && drawer.classList.contains('open')) {
        drawer.classList.remove('open');
        toggleBtn.classList.remove('open');
      }
    });
  }
}

function initMapActions() {
  const refreshBtn = document.getElementById('btn-refresh-map');
  const iframe = document.getElementById('kepler-map-iframe');

  if (refreshBtn && iframe) {
    refreshBtn.addEventListener('click', () => {
      refreshBtn.style.transform = 'rotate(180deg)';
      setTimeout(() => {
        refreshBtn.style.transform = '';
      }, 500);

      const src = iframe.src;
      iframe.src = '';
      iframe.src = src;
    });
  }
}


function setupImageZoom(wrapperId, imgId, lensId) {
  const wrapper = document.getElementById(wrapperId);
  const img = document.getElementById(imgId);
  const lens = document.getElementById(lensId);

  if (wrapper && img && lens) {
    wrapper.addEventListener('mousemove', moveLens);
    wrapper.addEventListener('mouseenter', showLens);
    wrapper.addEventListener('mouseleave', hideLens);

    wrapper.addEventListener('touchmove', (e) => {
      if (e.touches.length > 0) {
        moveLens(e.touches[0]);
      }
    });
    wrapper.addEventListener('touchstart', showLens);
    wrapper.addEventListener('touchend', hideLens);

    function showLens() {
      lens.style.visibility = 'visible';
      lens.style.backgroundImage = `url('${img.src}')`;
    }

    function hideLens() {
      lens.style.visibility = 'hidden';
    }

    function moveLens(e) {
      if (e.preventDefault) e.preventDefault();

      const rect = wrapper.getBoundingClientRect();
      
      let x = e.clientX - rect.left;
      let y = e.clientY - rect.top;

      if (x < 0) x = 0;
      if (y < 0) y = 0;
      if (x > rect.width) x = rect.width;
      if (y > rect.height) y = rect.height;

      const lensWidth = lens.offsetWidth;
      const lensHeight = lens.offsetHeight;
      
      lens.style.left = `${x - lensWidth / 2}px`;
      lens.style.top = `${y - lensHeight / 2}px`;

      const zoomFactor = 2.2;
      lens.style.backgroundSize = `${rect.width * zoomFactor}px ${rect.height * zoomFactor}px`;

      const posX = (x * zoomFactor) - (lensWidth / 2);
      const posY = (y * zoomFactor) - (lensHeight / 2);

      lens.style.backgroundPosition = `-${posX}px -${posY}px`;
    }
  }
}

function initImageZoom() {
  setupImageZoom('badmap-zoom-wrapper', 'badmap-img', 'badmap-lens');
  setupImageZoom('whiteboard-zoom-wrapper', 'whiteboard-img', 'whiteboard-lens');
}
