import React, { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { 
  Layers, 
  Terminal, 
  Monitor, 
  Github, 
  Mail, 
  Cpu, 
  ExternalLink,
  BookOpen,
  Award
} from 'lucide-react';
import ResumeViewer from './components/ResumeViewer';
import CodeExplorer from './components/CodeExplorer';
import DesktopTargetDownload from './components/DesktopTargetDownload';

export default function App() {
  const [activeWorkspace, setActiveWorkspace] = useState<'app' | 'code' | 'desktop'>('app');
  const [currentLanguage, setLanguage] = useState<'en' | 'fa'>('en');

  const workspaceTabs = [
    { id: 'app', label: 'Interactive WebAssembly App', icon: Layers, description: 'Simulated Qt Quick QML WebAssembly Container' },
    { id: 'code', label: 'C++ & QML Code Blueprints', icon: Terminal, description: 'QMake, C++ Backend, and QML Files' },
    { id: 'desktop', label: 'CI/CD Desktop Targets', icon: Monitor, description: 'Windows MinGW, Linux GCC, & Wasm Builds' },
  ] as const;

  return (
    <div className="min-h-screen bg-[#080810] text-gray-100 flex flex-col font-sans relative selection:bg-brand-cyan/25 selection:text-brand-cyan">
      
      {/* Immersive Atmospheric Ambient Glows */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none z-0">
        <div className="absolute top-[-10%] left-[-10%] w-[500px] h-[500px] bg-[#00F2FE] opacity-10 rounded-full blur-[120px] animate-glow-1"></div>
        <div className="absolute bottom-[-10%] right-[-10%] w-[500px] h-[500px] bg-[#4FACFE] opacity-10 rounded-full blur-[120px] animate-glow-2"></div>
      </div>

      {/* Global Navigation Header */}
      <header className="border-b border-white/5 bg-[#080810]/40 backdrop-blur-md sticky top-0 z-50 transition-all">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          
          {/* Logo Brand Block */}
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-gradient-to-tr from-[#00F2FE] to-[#4FACFE] p-[1.5px] shadow-lg shadow-[#00F2FE]/20">
              <div className="w-9 h-9 rounded-xl bg-[#080810] flex items-center justify-center">
                <Cpu className="w-5 h-5 text-[#00F2FE]" />
              </div>
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h1 className="text-base font-bold tracking-tight text-white font-display">
                  Alireza Reisiminab
                </h1>
                <span className="hidden sm:inline-block px-2 py-0.5 rounded bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[9px] font-mono text-[#00F2FE] font-semibold uppercase">
                  Qt 6.7 LTS Profile
                </span>
              </div>
              <p className="text-[11px] text-gray-400 font-mono tracking-wider">
                Qt/C++ WebAssembly Portfolio Showcase
              </p>
            </div>
          </div>

          {/* Social Profiles & Contacts Header Row */}
          <div className="flex items-center gap-3.5">
            <a 
              href="https://github.com/alirezareisiminab" 
              target="_blank" 
              rel="noopener noreferrer"
              className="p-2 rounded-lg bg-white/[0.02] border border-white/5 hover:border-[#00F2FE]/50 text-gray-400 hover:text-white transition-all hover:shadow-[0_0_12px_rgba(0,242,254,0.15)] cursor-pointer"
              title="GitHub Profile"
            >
              <Github className="w-4.5 h-4.5" />
            </a>
            <a 
              href="mailto:alirezareisiminab.imortal.1381@gmail.com"
              className="p-2 rounded-lg bg-white/[0.02] border border-white/5 hover:border-[#00F2FE]/50 text-gray-400 hover:text-white transition-all hover:shadow-[0_0_12px_rgba(0,242,254,0.15)] cursor-pointer"
              title="Email Contact"
            >
              <Mail className="w-4.5 h-4.5" />
            </a>
            <div className="hidden md:flex items-center gap-2 px-3 py-1 bg-emerald-500/10 border border-emerald-500/20 rounded-full text-[11px] font-mono text-emerald-400">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse" />
              <span>CI BUILD PASSING</span>
            </div>
          </div>
        </div>
      </header>

      {/* Main Container */}
      <main className="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 md:py-12 space-y-8 flex flex-col justify-center relative z-10">
        
        {/* Workspace Portfolio Explainer Hero */}
        <section className="text-center max-w-3xl mx-auto space-y-4">
          <motion.div 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white/[0.03] border border-white/10 text-xs font-mono text-[#00F2FE]"
          >
            <Award className="w-3.5 h-3.5 text-[#00F2FE]" />
            <span className="uppercase tracking-[0.15em] font-semibold text-[10px]">Dual-Language LTR/RTL Responsive Engine</span>
          </motion.div>
          
          <motion.h2 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="text-3xl sm:text-5xl font-light tracking-tight text-white font-display"
          >
            Cross-Platform <span className="font-bold bg-clip-text text-transparent bg-gradient-to-r from-[#00F2FE] to-[#4FACFE]">Qt QML Portfolio</span>
          </motion.h2>
          
          <motion.p 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="text-sm text-gray-400 leading-relaxed font-light"
          >
            Explore an interactive portfolio engineered with <strong>Qt Quick/QML (Front-end)</strong> and <strong>C++ (Back-end)</strong>, demonstrating native compilation targets across Windows x64, Linux x64, and browser-embedded WebAssembly.
          </motion.p>
        </section>

        {/* Workspace Mode Selection Cards */}
        <section className="grid grid-cols-1 md:grid-cols-3 gap-4 max-w-5xl mx-auto w-full">
          {workspaceTabs.map((tab) => {
            const IconComp = tab.icon;
            const isSelected = activeWorkspace === tab.id;
            return (
              <button
                key={tab.id}
                id={`workspace-tab-${tab.id}`}
                onClick={() => setActiveWorkspace(tab.id)}
                className={`p-5 rounded-2xl border text-left cursor-pointer transition-all flex items-start gap-4 select-none relative overflow-hidden group ${
                  isSelected 
                    ? 'bg-white/[0.03] border-[#00F2FE]/50 shadow-[0_0_20px_rgba(0,242,254,0.1)]' 
                    : 'bg-[#0c0c16]/50 border-white/5 hover:border-white/10 text-gray-300 hover:text-white'
                }`}
              >
                {isSelected && (
                  <div className="absolute top-0 right-0 w-24 h-24 bg-gradient-to-br from-[#00F2FE]/10 to-[#4FACFE]/10 rounded-full blur-xl pointer-events-none" />
                )}
                
                <div className={`p-2.5 rounded-xl border transition-all ${
                  isSelected 
                    ? 'bg-[#00F2FE]/10 border-[#00F2FE]/30 text-[#00F2FE]' 
                    : 'bg-white/[0.02] border-white/5 text-gray-400 group-hover:text-white'
                }`}>
                  <IconComp className="w-5 h-5" />
                </div>

                <div className="space-y-1">
                  <h4 className="text-xs font-bold text-white font-display tracking-wider uppercase">
                    {tab.label}
                  </h4>
                  <p className="text-[11px] text-gray-400 font-mono leading-snug font-light">
                    {tab.description}
                  </p>
                </div>
              </button>
            );
          })}
        </section>

        {/* Dynamic Display Panel */}
        <section className="w-full max-w-5xl mx-auto z-10">
          <AnimatePresence mode="wait">
            <motion.div
              key={activeWorkspace}
              initial={{ opacity: 0, y: 15 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -15 }}
              transition={{ duration: 0.25, ease: 'easeOut' }}
            >
              {activeWorkspace === 'app' && (
                <ResumeViewer 
                  currentLanguage={currentLanguage} 
                  setLanguage={setLanguage} 
                />
              )}
              
              {activeWorkspace === 'code' && (
                <CodeExplorer />
              )}
              
              {activeWorkspace === 'desktop' && (
                <div className="p-6 md:p-8 rounded-3xl bg-white/[0.03] border border-white/10 backdrop-blur-md shadow-2xl">
                  <DesktopTargetDownload />
                </div>
              )}
            </motion.div>
          </AnimatePresence>
        </section>

      </main>

      {/* Global Footer */}
      <footer className="border-t border-white/5 bg-black/40 py-8 text-center mt-auto z-10">
        <div className="max-w-7xl mx-auto px-4 text-[10px] text-gray-500 font-mono uppercase tracking-widest space-y-2">
          <p>
            Alireza Reisiminab © 2026. All Rights Reserved.
          </p>
          <div className="flex justify-center items-center gap-3.5 flex-wrap">
            <span>Powered by</span>
            <span className="text-[#00F2FE]">Qt Quick / QML 6.7</span>
            <span>•</span>
            <span className="text-[#4FACFE]">Emscripten WebAssembly</span>
            <span>•</span>
            <span className="text-[#00F2FE]">C++ Core Engines</span>
            <span>•</span>
            <span className="text-[#4FACFE]">React & Tailwind CSS v4</span>
          </div>
        </div>
      </footer>
    </div>
  );
}
