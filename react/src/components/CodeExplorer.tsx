import React, { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { 
  FileCode, 
  Terminal, 
  Copy, 
  Check, 
  ChevronRight, 
  Folder, 
  Info, 
  BookOpen,
  Cpu,
  CornerDownRight
} from 'lucide-react';
import { cppProjectData } from '../data/cppProjectData';
import { CodeFile } from '../types';

export default function CodeExplorer() {
  const [selectedFile, setSelectedFile] = useState<CodeFile>(cppProjectData[0]);
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(selectedFile.content);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy text', err);
    }
  };

  return (
    <div className="w-full flex flex-col bg-[#0c0c16]/65 border border-white/10 rounded-3xl shadow-2xl overflow-hidden backdrop-blur-xl">
      {/* Tab Control Title Bar */}
      <div className="flex items-center justify-between px-5 py-4 bg-[#080810]/80 border-b border-white/5">
        <div className="flex items-center gap-2">
          <Terminal className="w-5 h-5 text-[#00F2FE]" />
          <h3 className="text-xs font-semibold font-mono tracking-widest text-slate-200 uppercase">
            QT / C++ BLUEPRINT EXPLORER
          </h3>
        </div>
        <div className="flex items-center gap-2 px-3 py-1 rounded-md bg-white/[0.03] border border-white/5 text-[10px] font-mono text-[#00F2FE] tracking-wider uppercase">
          <BookOpen className="w-3.5 h-3.5" />
          <span>Qt 6.7 LTS DEPLOYMENT</span>
        </div>
      </div>

      <div className="flex flex-col lg:flex-row min-h-[500px]">
        {/* A. File Tree Navigation */}
        <div className="w-full lg:w-64 bg-black/20 border-r border-b lg:border-b-0 border-white/5 p-4 shrink-0 select-none">
          <div className="text-[10px] font-mono font-bold text-gray-500 uppercase tracking-widest mb-3 px-2 flex items-center gap-1.5">
            <Folder className="w-4.5 h-4.5 text-[#00F2FE]/60" />
            <span>Workspace Files</span>
          </div>

          <div className="space-y-1.5">
            {cppProjectData.map((file) => {
              const isSelected = file.path === selectedFile.path;
              return (
                <button
                  key={file.path}
                  id={`file-tree-${file.name}`}
                  onClick={() => {
                    setSelectedFile(file);
                    setCopied(false);
                  }}
                  className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl text-xs font-mono text-left cursor-pointer transition-all ${
                    isSelected 
                      ? 'bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[#00F2FE] shadow-inner' 
                      : 'text-gray-400 hover:text-white hover:bg-white/[0.02] border border-transparent'
                  }`}
                >
                  <div className="flex items-center gap-2 truncate">
                    <FileCode className={`w-4 h-4 shrink-0 ${isSelected ? 'text-[#00F2FE]' : 'text-gray-500'}`} />
                    <span className="truncate font-light">{file.name}</span>
                  </div>
                  <ChevronRight className={`w-3.5 h-3.5 shrink-0 transition-transform ${isSelected ? 'text-[#00F2FE] rotate-90' : 'text-gray-600'}`} />
                </button>
              );
            })}
          </div>

          {/* Compilation Quick-Info */}
          <div className="mt-8 p-4 rounded-2xl bg-white/[0.02] border border-white/5 text-[11px] font-sans text-gray-400 space-y-2.5 font-light">
            <h4 className="font-mono text-white font-bold uppercase tracking-widest flex items-center gap-1.5 text-[10px]">
              <Cpu className="w-3.5 h-3.5 text-[#00F2FE]" />
              <span>Qt Compiler Core</span>
            </h4>
            <p className="leading-relaxed">
              To build this locally, configure your kit with <strong>Qt 6.7.x Desktop GCC</strong> or <strong>Emscripten</strong>, run <code>qmake</code> or <code>cmake</code>, then <code>make</code>.
            </p>
          </div>
        </div>

        {/* B. Code Preview Area */}
        <div className="flex-1 flex flex-col bg-black/10">
          {/* File Metadata Info Box */}
          <div className="p-4 bg-black/20 border-b border-white/5 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <span className="font-mono font-bold text-slate-300">{selectedFile.path}</span>
                <span className="px-2 py-0.5 rounded bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[9px] font-mono text-[#00F2FE] uppercase tracking-wider">
                  {selectedFile.language}
                </span>
              </div>
              <p className="text-gray-400 font-sans text-xs max-w-xl leading-relaxed font-light">
                {selectedFile.description}
              </p>
            </div>

            {/* Copy Button */}
            <button
              id="copy-code-btn"
              onClick={handleCopy}
              className={`flex items-center gap-2 px-3.5 py-2 rounded-xl font-mono text-[10px] uppercase tracking-wider font-bold cursor-pointer transition-all self-start sm:self-center ${
                copied 
                  ? 'bg-emerald-500/10 border border-emerald-500/20 text-emerald-400' 
                  : 'bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[#00F2FE] hover:bg-[#00F2FE]/20'
              }`}
            >
              {copied ? <Check className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
              <span>{copied ? 'Copied!' : 'Copy Code'}</span>
            </button>
          </div>

          {/* Syntax Highlighted Code Canvas */}
          <div className="flex-1 p-5 overflow-auto max-h-[500px] font-mono text-xs leading-relaxed scrollbar-thin scrollbar-thumb-white/10 scrollbar-track-transparent">
            <pre className="text-slate-300 text-left bg-transparent rounded-none p-0 border-0 select-text select-all whitespace-pre">
              <code>
                {selectedFile.content.split('\n').map((line, idx) => (
                  <div key={idx} className="flex select-none group">
                    <span className="w-8 text-right pr-4 text-gray-600 select-none border-r border-white/5 mr-4 font-sans text-[10px]">
                      {idx + 1}
                    </span>
                    <span className="flex-1 select-text selection:bg-[#00F2FE]/10 selection:text-white">
                      {/* Very basic manual highlighting for visual polish */}
                      {highlightLine(line, selectedFile.language)}
                    </span>
                  </div>
                ))}
              </code>
            </pre>
          </div>
        </div>
      </div>
    </div>
  );
}

// Visual polish manual syntax highlighter helper for pre/code line blocks
function highlightLine(line: string, lang: 'cpp' | 'qml' | 'json' | 'yaml' | 'pro') {
  if (!line.trim()) return <span className="opacity-0"> </span>;

  // 1. Comments
  if (line.trim().startsWith('//') || line.trim().startsWith('#')) {
    return <span className="text-slate-500 italic font-mono">{line}</span>;
  }

  // 2. String matches
  let highlighted: React.ReactNode[] = [];
  
  // Custom keyword mappings
  const keywords = [
    'class', 'explicit', 'nullptr', 'const', 'void', 'bool', 'int', 'char', 'float', 'double',
    'return', 'if', 'else', 'for', 'while', 'switch', 'case', 'default', 'import', 'property',
    'alias', 'signals', 'public', 'private', 'explicit', 'Q_PROPERTY', 'Q_INVOKABLE', 'emit',
    'slots', 'on', 'runs-on', 'uses', 'with', 'steps', 'name', 'on:', 'jobs:', 'QT', 'CONFIG',
    'SOURCES', 'HEADERS', 'RESOURCES', 'INSTALLS'
  ];

  const qtKeywords = [
    'QString', 'QObject', 'QVariantList', 'QJsonObject', 'QFile', 'QJsonDocument', 'QJsonArray',
    'QGuiApplication', 'QQmlApplicationEngine', 'QQmlContext', 'QUrl', 'QCoreApplication',
    'ApplicationWindow', 'Rectangle', 'RowLayout', 'StackLayout', 'Sidebar', 'OverviewPage',
    'ExperiencePage', 'SkillsPage', 'ContactPage', 'MouseArea', 'Behavior', 'ColorAnimation',
    'Gradient', 'GradientStop'
  ];

  // Simple token regex parsing
  const words = line.split(/(\s+|=|\{|\}|\(|\)|\,|;|\:|\+|\*|\/|\&|<|>)/);

  return words.map((word, wIdx) => {
    const trimmed = word.trim();
    if (keywords.includes(trimmed)) {
      return <span key={wIdx} className="text-[#4FACFE] font-bold">{word}</span>;
    }
    if (qtKeywords.includes(trimmed)) {
      return <span key={wIdx} className="text-[#00F2FE] font-semibold">{word}</span>;
    }
    if (trimmed.startsWith('"') && trimmed.endsWith('"')) {
      return <span key={wIdx} className="text-emerald-400">{word}</span>;
    }
    if (trimmed.startsWith('<') && trimmed.endsWith('>')) {
      return <span key={wIdx} className="text-emerald-400">{word}</span>;
    }
    if (trimmed.startsWith('m_')) {
      return <span key={wIdx} className="text-pink-400">{word}</span>;
    }
    if (/^\d+(\.\d+)?$/.test(trimmed)) {
      return <span key={wIdx} className="text-amber-400 font-mono">{word}</span>;
    }
    return <span key={wIdx}>{word}</span>;
  });
}
