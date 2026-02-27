# Deep Blood Reactor

An audio-reactive 3D visualizer built with Three.js that creates a blood-red cylinder energy core that responds to microphone input.

## Features

- **Real-time Audio Analysis**: Reacts to microphone input with FFT analysis
- **6 Color Palettes**: Blood Red, Void Purple, Toxic Emerald, Electric Blue, Inferno Orange, Ghost Plasma
- **Performance Optimized**: Uses instanced meshes for efficient rendering (64 energy bars in 1 draw call)
- **Multiple Deployment Modes**: Web app, Electron desktop app, and Nix Linux package
- **Enhanced Error Handling**: Graceful handling of microphone permission issues
- **Performance Monitoring**: Real-time FPS counter with color-coded performance indicators
- **Persistent Settings**: User preferences saved to localStorage
- **Keyboard Controls**: Palette switching, fullscreen, and settings toggles
- **VSync & FPS Limiting**: Desktop versions support VSync and configurable FPS limits (30-144Hz)
- **Audio Monitor Detection**: Automatically detects system audio monitors for desktop audio capture
- **Hardware Acceleration**: Optimized for desktop deployment with GPU acceleration

## Installation & Usage

### Web Version
Simply open `index.html` in a modern browser that supports Web Audio API.

### Electron Desktop App
```bash
npm install
electron main.js
```

### Nix Package (Linux)
```bash
nix run github:username/tha-cylinda
# or install system-wide
nix profile install github:ALH477/tha-cylinda
```

## Controls

- **1-6**: Switch between color palettes
- **R**: Random palette
- **F**: Toggle fullscreen
- **H**: Hide/show info text
- **S**: Toggle FPS counter
- **A**: Toggle audio status indicator
- **M**: Toggle audio source (Default ↔ System Monitor)
- **V**: Toggle VSync
- **+/-**: Adjust FPS limit (30-144 Hz)

## Audio Requirements

The application requires microphone access to function. When you first start the visualizer, you'll need to:
1. Click the "START DEEP BLOOD REACTOR CORE (MIC)" button
2. Grant microphone permissions when prompted
3. Speak or play music near your microphone to see the visualizer react

## Error Handling

The application includes robust error handling for:
- **Permission Denied**: Shows retry button if microphone access is denied
- **Microphone Busy**: Handles cases where microphone is in use by another application
- **Audio Context Errors**: Graceful fallback for audio initialization failures

## Performance Features

- **FPS Monitoring**: Real-time performance counter in top-right corner
- **Adaptive Quality**: Automatic pixel ratio limiting for older devices
- **Efficient Rendering**: Single instanced mesh for all energy bars
- **Memory Management**: Proper cleanup and disposal of resources

## Settings

User preferences are automatically saved and include:
- Selected color palette
- FPS counter visibility
- Audio status indicator visibility

## Technical Details

### Dependencies
- Three.js (r134) - 3D rendering
- Web Audio API - Audio analysis
- Electron (optional) - Desktop deployment
- Nix (optional) - Linux packaging

### Performance Optimizations
- InstancedMesh for energy bars (1 draw call for 64 bars)
- Limited geometry complexity (64 cylinder segments)
- Dynamic pixel ratio capping (max 2x)
- Efficient audio processing (256 FFT with smoothing)

### Browser Support
- Chrome/Chromium (recommended)
- Firefox
- Safari (with Web Audio API support)
- Edge

## Development

### Building
No build process required for the web version. For production deployment:
1. Minify JavaScript and CSS
2. Use a CDN for Three.js
3. Consider adding a service worker for offline functionality

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Troubleshooting

### No Audio Response
- Ensure microphone permissions are granted
- Check that your microphone is working in other applications
- Try speaking louder or playing music closer to the microphone

### Performance Issues
- Close other browser tabs and applications
- Reduce browser zoom level
- Check the FPS counter - green indicates good performance

### Permission Errors
- Check browser settings for microphone permissions
- Try refreshing the page and granting permissions again
- Ensure no other applications are using the microphone

## License

MIT License - see LICENSE file for details.

## Credits

Built with ❤️ using Three.js and Web Audio API.

Original concept and implementation by Asher.

Contributions welcome!
