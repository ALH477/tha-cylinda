const {app,BrowserWindow} = require('electron');
app.whenReady().then(()=>{
  const win = new BrowserWindow({width:1920,height:1080,frame:false,transparent:true,alwaysOnTop:false,backgroundColor:'#000000'});
  win.loadFile('blood-reactor.html?embed=1');
  win.setIgnoreMouseEvents(true); // click-through if you want pure wallpaper
});