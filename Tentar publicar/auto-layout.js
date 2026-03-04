/**
 * Auto Layout Adjuster - LumaFluxo
 * Ajusta o diagrama automaticamente quando sidebar abre/fecha
 */

(function() {
    'use strict';
    
    let isAdjusting = false; // Flag para evitar loop
    let lastSidebarState = null; // Rastrear estado anterior
    let observer = null; // Observer global para poder desconectar
    
    console.log('🔄 Auto Layout Adjuster iniciando...');
    
    // Aguardar carregamento completo + tempo extra para Bizagi renderizar
    window.addEventListener('load', function() {
        // Aguardar mais tempo para garantir que Bizagi carregou completamente
        setTimeout(function() {
            // Verificar se Kinetic.js e diagrama estão prontos
            if (typeof Kinetic === 'undefined') {
                console.warn('⚠️ Kinetic.js não carregado ainda, aguardando...');
                setTimeout(initAutoLayout, 2000);
                return;
            }
            
            if (!Kinetic.stages || Kinetic.stages.length === 0) {
                console.warn('⚠️ Diagrama não renderizado ainda, aguardando...');
                setTimeout(initAutoLayout, 2000);
                return;
            }
            
            initAutoLayout();
        }, 3000); // 3 segundos para garantir carregamento completo
    });
    
    function initAutoLayout() {
        const sidebar = document.getElementById('sidebar');
        
        if (!sidebar) {
            console.warn('⚠️ Sidebar não encontrado');
            return;
        }
        
        // Verificar novamente se Kinetic está pronto
        if (typeof Kinetic === 'undefined' || !Kinetic.stages || Kinetic.stages.length === 0) {
            console.warn('⚠️ Diagrama ainda não está pronto');
            return;
        }
        
        console.log('✅ Auto Layout Adjuster ativo');
        
        // NÃO ajustar inicialmente para não interferir com carregamento do Bizagi
        // adjustDiagramLayout(); // DESABILITADO - deixa Bizagi carregar naturalmente
        
        // Capturar estado inicial do sidebar
        lastSidebarState = window.getComputedStyle(sidebar).display !== 'none';
        
        // Observar mudanças no sidebar
        observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'style' && !isAdjusting) {
                    // Verificar se sidebar realmente mudou de estado
                    const currentState = window.getComputedStyle(sidebar).display !== 'none';
                    
                    if (lastSidebarState !== currentState) {
                        console.log('🔄 Sidebar mudou:', currentState ? 'ABERTO' : 'FECHADO');
                        lastSidebarState = currentState;
                        adjustDiagramLayout();
                    }
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['style']
        });
        
        // Ajustar quando redimensionar janela
        window.addEventListener('resize', debounce(function() {
            if (!isAdjusting) {
                adjustDiagramLayout();
            }
        }, 250));
        
        console.log('👀 Observando mudanças no sidebar');
    }
    
    /**
     * Ajusta layout do diagrama baseado na visibilidade do sidebar
     */
    function adjustDiagramLayout() {
        if (isAdjusting) return; // Evitar loop
        
        isAdjusting = true;
        
        // DESCONECTAR observer temporariamente para evitar loop
        if (observer) {
            observer.disconnect();
        }
        
        const sidebar = document.getElementById('sidebar');
        const wrapper = document.querySelector('.biz-ex-wrapper');
        const layout = document.querySelector('.biz-ex-layout');
        const diagramContainer = document.querySelector('.biz-ex-diagram-update-panel-container');
        
        if (!sidebar || !wrapper) {
            isAdjusting = false;
            // RECONECTAR observer
            if (observer) {
                observer.observe(sidebar, {
                    attributes: true,
                    attributeFilter: ['style']
                });
            }
            return;
        }
        
        // Verificar se sidebar está visível
        const sidebarVisible = window.getComputedStyle(sidebar).display !== 'none';
        const sidebarWidth = sidebarVisible ? sidebar.offsetWidth : 0;
        
        console.log('📐 Ajustando layout:', {
            sidebarVisible: sidebarVisible,
            sidebarWidth: sidebarWidth
        });
        
        // Ajustar containers principais
        if (wrapper) {
            wrapper.style.width = '100%';
            wrapper.style.maxWidth = '100%';
            wrapper.style.margin = '0';
            wrapper.style.padding = '10px';
        }
        
        if (layout) {
            layout.style.width = '100%';
            layout.style.maxWidth = '100%';
            layout.style.margin = '0';
        }
        
        if (diagramContainer) {
            // Calcular largura disponível
            const availableWidth = window.innerWidth - sidebarWidth - 40; // 40px de padding
            
            diagramContainer.style.width = '100%';
            diagramContainer.style.maxWidth = '100%';
            
            if (!sidebarVisible) {
                // Sidebar fechado - usar tela toda
                diagramContainer.style.marginLeft = '0';
            }
        }
        
        // Redimensionar canvas do Kinetic.js
        resizeKineticCanvas();
        
        // Aguardar um pouco antes de liberar a flag e reconectar observer
        setTimeout(function() {
            isAdjusting = false;
            
            // RECONECTAR observer
            if (observer && sidebar) {
                observer.observe(sidebar, {
                    attributes: true,
                    attributeFilter: ['style']
                });
            }
        }, 300);
    }
    
    /**
     * Redimensiona canvas do Kinetic.js
     */
    function resizeKineticCanvas() {
        // Tentar acessar stage do Kinetic.js
        if (typeof Kinetic !== 'undefined' && Kinetic.stages && Kinetic.stages.length > 0) {
            const stage = Kinetic.stages[0];
            
            // Pegar container
            const container = stage.getContainer();
            const containerWidth = container.offsetWidth;
            
            // Redimensionar stage
            if (containerWidth > 0) {
                stage.setWidth(containerWidth);
                stage.draw();
                
                console.log('📊 Canvas redimensionado:', containerWidth + 'px');
            }
        }
    }
    
    /**
     * Debounce function para evitar muitas chamadas
     */
    function debounce(func, wait) {
        let timeout;
        return function() {
            const context = this;
            const args = arguments;
            clearTimeout(timeout);
            timeout = setTimeout(function() {
                func.apply(context, args);
            }, wait);
        };
    }
    
})();
