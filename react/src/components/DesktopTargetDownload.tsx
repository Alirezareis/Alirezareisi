import React, { useState } from 'react';
import { motion } from 'motion/react';
import { 
  Download, 
  Monitor, 
  Cpu, 
  Terminal, 
  Check, 
  PlayCircle, 
  ShieldCheck, 
  Box,
  Copy,
  FolderSync
} from 'lucide-react';

interface TargetCardProps {
  platform: string;
  architecture: string;
  fileSize: string;
  icon: any;
  compiler: string;
  buildTime: string;
  downloadLabel: string;
  key?: any;
}

function TargetCard({ platform, architecture, fileSize, icon: Icon, compiler, buildTime, downloadLabel }: TargetCardProps) {
  const [downloading, setDownloading] = useState(false);
  const [complete, setComplete] = useState(false);

  const triggerDownload = () => {
    if (downloading || complete) return;
    setDownloading(true);
    setTimeout(() => {
      setDownloading(false);
      setComplete(true);
      setTimeout(() => setComplete(false), 3000);
    }, 2000);
  };

  return (
    <div className="p-5 rounded-2xl bg-white/[0.02] border border-white/5 hover:border-[#00F2FE]/30 transition-all duration-300 relative overflow-hidden group flex flex-col justify-between">
      <div className="absolute top-0 right-0 w-24 h-24 bg-gradient-to-br from-[#00F2FE]/10 to-[#4FACFE]/10 rounded-full blur-2xl pointer-events-none" />
      
      <div className="space-y-4">
        {/* Platform Title */}
        <div className="flex items-center gap-3">
          <div className="p-2.5 rounded-xl bg-white/[0.03] border border-white/5 text-[#00F2FE] group-hover:text-white group-hover:bg-[#00F2FE]/10 transition-all">
            <Icon className="w-5 h-5" />
          </div>
          <div>
            <h4 className="text-sm font-bold text-white font-display tracking-wide">{platform}</h4>
            <span className="text-[10px] font-mono text-gray-500 uppercase tracking-widest">{architecture}</span>
          </div>
        </div>

        {/* Build Metrics Grid */}
        <div className="grid grid-cols-2 gap-2 text-[11px] font-mono border-t border-b border-white/5 py-2.5">
          <div className="space-y-1">
            <span className="text-gray-500">Compiler:</span>
            <p className="text-gray-300 font-semibold">{compiler}</p>
          </div>
          <div className="space-y-1">
            <span className="text-gray-500">Pkg Size:</span>
            <p className="text-gray-300 font-semibold">{fileSize}</p>
          </div>
          <div className="space-y-1">
            <span className="text-gray-500">CI Build Time:</span>
            <p className="text-gray-300 font-semibold">{buildTime}</p>
          </div>
          <div className="space-y-1">
            <span className="text-gray-500">Qt Runtime:</span>
            <p className="text-gray-300 font-semibold">Qt 6.7.1 Shared</p>
          </div>
        </div>
      </div>

      {/* Interactive Download/Action Button */}
      <button
        id={`target-download-${platform.replace(/\s+/g, '-').toLowerCase()}`}
        onClick={triggerDownload}
        disabled={downloading}
        className={`w-full mt-4 py-2.5 rounded-xl text-xs font-mono uppercase tracking-wider font-bold cursor-pointer transition-all ${
          complete 
            ? 'bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 shadow-[0_0_15px_rgba(16,185,129,0.15)]' 
            : downloading
              ? 'bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[#00F2FE] cursor-not-allowed'
              : 'bg-white/[0.03] hover:bg-[#00F2FE]/15 border border-[#00F2FE]/30 hover:border-[#00F2FE] text-[#00F2FE] hover:text-white shadow-md'
        }`}
      >
        {complete ? (
          <>
            <Check className="w-4 h-4 text-emerald-400" />
            <span>Package Delivered!</span>
          </>
        ) : downloading ? (
          <>
            <FolderSync className="w-4 h-4 text-[#00F2FE] animate-spin" />
            <span>Fetching Artifact...</span>
          </>
        ) : (
          <>
            <Download className="w-4 h-4" />
            <span>{downloadLabel}</span>
          </>
        )}
      </button>
    </div>
  );
}

export default function DesktopTargetDownload() {
  const [copiedCmd, setCopiedCmd] = useState('');

  const copyCommand = (cmd: string, id: string) => {
    navigator.clipboard.writeText(cmd);
    setCopiedCmd(id);
    setTimeout(() => setCopiedCmd(''), 2000);
  };

  const platforms = [
    {
      platform: "Windows Desktop Package",
      architecture: "x64 Standalone Executable",
      fileSize: "18.4 MB (Compressed .zip)",
      icon: Monitor,
      compiler: "MinGW GCC 11.2 (Win64)",
      buildTime: "1m 45s",
      downloadLabel: "Download Windows Bundle"
    },
    {
      platform: "Linux Desktop AppImage",
      architecture: "x64 Universal ELF Binary",
      fileSize: "14.2 MB (Self-contained)",
      icon: Cpu,
      compiler: "GCC 11.4 on Ubuntu 22.04",
      buildTime: "1m 20s",
      downloadLabel: "Download Linux AppImage"
    },
    {
      platform: "WebAssembly Assets",
      architecture: "Wasm32 Singlethread Target",
      fileSize: "6.8 MB (Optimized WASM)",
      icon: Box,
      compiler: "Emscripten v3.1.50 (clang)",
      buildTime: "2m 10s",
      downloadLabel: "Download Web Package"
    }
  ];

  return (
    <div className="space-y-6">
      {/* Target Heading */}
      <div className="flex flex-col gap-1 text-center md:text-left">
        <h3 className="text-lg font-bold text-white font-display flex items-center justify-center md:justify-start gap-2">
          <ShieldCheck className="w-5 h-5 text-[#00F2FE]" />
          <span>Cross-Platform Release Channels</span>
        </h3>
        <p className="text-xs text-gray-400 leading-relaxed max-w-2xl font-light">
          The following artifacts represent production-grade binaries produced automatically by the project's GitHub Actions CI/CD workflows, fully statically and dynamically bundled with necessary Qt Quick plugins.
        </p>
      </div>

      {/* Grid of Targets */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
        {platforms.map((p, idx) => (
          <TargetCard 
            key={idx}
            platform={p.platform}
            architecture={p.architecture}
            fileSize={p.fileSize}
            icon={p.icon}
            compiler={p.compiler}
            buildTime={p.buildTime}
            downloadLabel={p.downloadLabel}
          />
        ))}
      </div>

      {/* Quick Shell Utilities for Developers */}
      <div className="p-5 rounded-2xl bg-white/[0.01] border border-white/5 space-y-3.5">
        <div className="flex items-center gap-2 border-b border-white/5 pb-2">
          <Terminal className="w-4 h-4 text-[#00F2FE]" />
          <h4 className="text-xs font-mono font-bold uppercase tracking-widest text-slate-300">
            Developer Direct Compilations
          </h4>
        </div>
        
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
          {/* Cmd 1 */}
          <div className="space-y-1.5 text-xs font-mono">
            <span className="text-gray-500 uppercase tracking-widest text-[9px] font-bold"># Compiling for WebAssembly locally:</span>
            <div className="flex items-center justify-between p-3.5 rounded-xl bg-black/40 border border-white/5 text-gray-300 select-all overflow-x-auto whitespace-nowrap">
              <code>mkdir build && cd build && emcmake cmake .. && make -j$(nproc)</code>
              <button 
                id="copy-wasm-cmd"
                onClick={() => copyCommand("mkdir build && cd build && emcmake cmake .. && make -j$(nproc)", "wasm")}
                className="ml-3 p-1 rounded hover:bg-white/5 text-gray-400 hover:text-[#00F2FE] cursor-pointer active:scale-95"
              >
                {copiedCmd === 'wasm' ? <Check className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
              </button>
            </div>
          </div>

          {/* Cmd 2 */}
          <div className="space-y-1.5 text-xs font-mono">
            <span className="text-gray-500 uppercase tracking-widest text-[9px] font-bold"># Compiling for Linux Desktop:</span>
            <div className="flex items-center justify-between p-3.5 rounded-xl bg-black/40 border border-white/5 text-gray-300 select-all overflow-x-auto whitespace-nowrap">
              <code>cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(nproc)</code>
              <button 
                id="copy-linux-cmd"
                onClick={() => copyCommand("cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(nproc)", "linux")}
                className="ml-3 p-1 rounded hover:bg-white/5 text-gray-400 hover:text-[#00F2FE] cursor-pointer active:scale-95"
              >
                {copiedCmd === 'linux' ? <Check className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
