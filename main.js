const {app,BrowserWindow} = require('electron');
const {webFrame} = require('electron');

// Configure VSync and performance settings
app.commandLine.appendSwitch('enable-gpu-vsync');
app.commandLine.appendSwitch('enable-accelerated-2d-canvas');
app.commandLine.appendSwitch('enable-gpu-rasterization');
app.commandLine.appendSwitch('enable-zero-copy');
app.commandLine.appendSwitch('disable-software-rasterizer');

// Optional: Set specific FPS limit (comment out for adaptive)
// app.commandLine.appendSwitch('max-gum-fps', '60');

app.whenReady().then(()=>{
  const win = new BrowserWindow({
    width:1920,
    height:1080,
    frame:false,
    transparent:true,
    alwaysOnTop:false,
    backgroundColor:'#000000',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false,
      // Enable hardware acceleration
      hardwareAcceleration: true,
      // Optimize for performance
      offscreen: false
    }
  });
  
  // Set frame rate for smoother rendering (60 FPS)
  win.webContents.on('dom-ready', () => {
    try {
      // Set frame rate to 60 FPS for smooth VSync
      win.webContents.executeJavaScript(`
        if (window.require) {
          const { webFrame } = window.require('electron');
          webFrame.setFrameRate(60);
        }
      `);
    } catch (e) {
      console.log('Frame rate setting not available in this context');
    }
  });
  
  win.loadFile('index.html?embed=1');
  win.setIgnoreMouseEvents(true); // click-through if you want pure wallpaper
  
  // Performance monitoring
  win.webContents.on('render-process-gone', (event, details) => {
    console.log('Renderer process gone:', details.reason);
    if (details.reason === 'crashed') {
      console.log('Attempting to restart renderer...');
      win.reload();
    }
  });
});
