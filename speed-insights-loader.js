/**
 * Vercel Speed Insights Loader
 * Initializes Speed Insights for the ContTech ERP application
 */

// Initialize Speed Insights queue
(function() {
  'use strict';
  
  // Initialize the Speed Insights queue if not already present
  if (!window.si) {
    window.si = function() {
      (window.siq = window.siq || []).push(arguments);
    };
  }
  
  // Check if we're in production environment
  var isDevelopment = function() {
    try {
      // Check for localhost or common dev hostnames
      var hostname = window.location.hostname;
      return hostname === 'localhost' || 
             hostname === '127.0.0.1' || 
             hostname.startsWith('192.168.') ||
             hostname.startsWith('10.');
    } catch (e) {
      return false;
    }
  };
  
  // Don't inject in development mode (unless explicitly enabled)
  if (isDevelopment()) {
    console.log('[Vercel Speed Insights] Development mode detected - tracking disabled');
    return;
  }
  
  // Create and inject the Speed Insights script
  var script = document.createElement('script');
  script.src = '/_vercel/speed-insights/script.js';
  script.defer = true;
  script.dataset.sdkn = '@vercel/speed-insights';
  script.dataset.sdkv = '1.3.1';
  
  script.onerror = function() {
    console.log(
      '[Vercel Speed Insights] Failed to load script. Please check if any content blockers are enabled and try again.'
    );
  };
  
  document.head.appendChild(script);
})();
