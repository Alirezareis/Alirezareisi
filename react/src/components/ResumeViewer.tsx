import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { 
  User, 
  Briefcase, 
  Cpu, 
  Mail, 
  MapPin, 
  Github, 
  ExternalLink, 
  CheckCircle2, 
  AlertCircle,
  Globe,
  CornerDownRight,
  Send,
  Download,
  Terminal,
  Activity,
  Layers,
  FileCode
} from 'lucide-react';
import { resumeData } from '../data/resumeData';
import { ResumeContent } from '../types';

interface ResumeViewerProps {
  currentLanguage: 'en' | 'fa';
  setLanguage: (lang: 'en' | 'fa') => void;
}

export default function ResumeViewer({ currentLanguage, setLanguage }: ResumeViewerProps) {
  const content: ResumeContent = resumeData[currentLanguage];
  const isRtl = currentLanguage === 'fa';
  const [activeTab, setActiveTab] = useState<'overview' | 'experience' | 'skills' | 'contact'>('overview');
  
  // Form States
  const [formName, setFormName] = useState('');
  const [formEmail, setFormEmail] = useState('');
  const [formMessage, setFormMessage] = useState('');
  const [formStatus, setFormStatus] = useState<'idle' | 'validating' | 'sending' | 'success' | 'error'>('idle');
  const [statusText, setStatusText] = useState('');

  // Animate skill bars on tab focus
  const [animateProgress, setAnimateProgress] = useState(false);
  useEffect(() => {
    if (activeTab === 'skills') {
      setAnimateProgress(true);
    } else {
      setAnimateProgress(false);
    }
  }, [activeTab]);

  // Reset form status after success
  useEffect(() => {
    if (formStatus === 'success') {
      const timer = setTimeout(() => {
        setFormStatus('idle');
        setFormName('');
        setFormEmail('');
        setFormMessage('');
      }, 5000);
      return () => clearTimeout(timer);
    }
  }, [formStatus]);

  // Handle Form Submission Mocking C++ QObject Backend logic
  const handleFormSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    // Step 1: UI Validation
    if (!formName.trim() || !formEmail.trim() || !formEmail.includes('@') || !formMessage.trim()) {
      setFormStatus('error');
      setStatusText(content.labels.sentError);
      return;
    }

    setFormStatus('sending');
    setStatusText(content.labels.sending);

    // Simulate C++ Backend slot response delay
    setTimeout(() => {
      setFormStatus('success');
      setStatusText(content.labels.sentSuccess);
    }, 1800);
  };

  // Switch Language dynamic toggle
  const toggleLanguage = () => {
    setLanguage(currentLanguage === 'en' ? 'fa' : 'en');
  };

  const tabs = [
    { id: 'overview', label: content.labels.overview, icon: User },
    { id: 'experience', label: content.labels.experience, icon: Briefcase },
    { id: 'skills', label: content.labels.skills, icon: Cpu },
    { id: 'contact', label: content.labels.contact, icon: Mail },
  ] as const;

  return (
    <div 
      id="qt-wasm-sandbox-container" 
      className="w-full flex flex-col bg-[#0c0c16]/65 border border-white/10 rounded-2xl shadow-2xl overflow-hidden backdrop-blur-xl transition-all duration-300 hover:shadow-[#00F2FE]/10"
      dir={isRtl ? 'rtl' : 'ltr'}
    >
      {/* 1. QT WASM OS Header Bar */}
      <div className="flex items-center justify-between px-4 py-3 bg-[#080810]/80 border-b border-white/5 select-none">
        {/* Windows Widgets */}
        <div className={`flex items-center gap-2 ${isRtl ? 'order-2' : 'order-1'}`}>
          <div className="w-3 h-3 rounded-full bg-[#rose-500] bg-red-500/80 cursor-pointer hover:bg-red-600 transition-colors" title="Close Frame" />
          <div className="w-3 h-3 rounded-full bg-amber-500/80 cursor-pointer hover:bg-amber-600 transition-colors" title="Minimize Frame" />
          <div className="w-3 h-3 rounded-full bg-emerald-500/80 cursor-pointer hover:bg-emerald-600 transition-colors" title="Maximize Frame" />
          <span className="ml-2 text-[10px] font-mono tracking-widest text-gray-500 uppercase hidden md:inline">
            Qt 6.7.1 WASM SINGLETHREAD
          </span>
        </div>

        {/* Dynamic Sandbox Title */}
        <div className={`flex items-center gap-2 text-xs font-mono text-[#00F2FE] font-semibold ${isRtl ? 'order-1' : 'order-2'}`}>
          <Layers className="w-4 h-4 text-[#00F2FE] animate-pulse" />
          <span className="tracking-wider uppercase text-[10px]">{content.labels.webAssemblyCanvas}</span>
        </div>

        {/* Quick Config Toggles */}
        <div className={`flex items-center gap-3 ${isRtl ? 'order-1 md:order-3' : 'order-2 md:order-3'}`}>
          {/* C++ Bound Connection Status Indicator */}
          <div className="hidden lg:flex items-center gap-1.5 px-2.5 py-0.5 rounded-md bg-white/[0.03] border border-white/5 text-[10px] font-mono text-[#00F2FE]">
            <Activity className="w-3 h-3 text-[#00F2FE] animate-pulse" />
            <span>C++ SLOT CONNECTED</span>
          </div>

          <button 
            id="lang-toggle-btn"
            onClick={toggleLanguage}
            className="flex items-center gap-1.5 px-3 py-1 text-xs font-mono uppercase tracking-wider text-white bg-[#00F2FE]/15 hover:bg-[#00F2FE]/25 border border-[#00F2FE]/30 hover:border-[#00F2FE] rounded-md transition-all cursor-pointer active:scale-95"
          >
            <Globe className="w-3.5 h-3.5 text-[#00F2FE]" />
            <span>{content.labels.switchLang}</span>
          </button>
        </div>
      </div>

      {/* 2. Qt Layout Canvas (Sidebar + Content Stack) */}
      <div className="flex flex-col md:flex-row min-h-[580px] bg-gradient-to-b from-[#0c0c16]/30 to-[#080810]/30 relative">
        
        {/* Subtle decorative grid/glow behind content */}
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_120%,rgba(0,242,254,0.08),transparent_60%)] pointer-events-none" />

        {/* A. Sidebar Navigation */}
        <div className="w-full md:w-64 bg-black/20 border-r border-b md:border-b-0 border-white/5 p-4 md:p-6 flex flex-col justify-between shrink-0 select-none z-10">
          <div className="flex flex-col gap-6">
            {/* Logo and Quick Info */}
            <div className={`flex flex-col gap-1.5 ${isRtl ? 'text-right' : 'text-left'}`}>
              <div className="text-[10px] font-mono text-[#4FACFE] font-bold uppercase tracking-widest flex items-center gap-1">
                <Terminal className="w-3.5 h-3.5 text-[#00F2FE]" />
                <span>QML RUNTIME ENGINE</span>
              </div>
              <h2 className="text-xl font-bold tracking-tight text-white font-display">
                {content.name}
              </h2>
              <p className="text-xs text-gray-400 leading-relaxed min-h-[32px] font-light">
                {content.title}
              </p>
            </div>

            {/* QML-Style Menu Selector */}
            <div className="flex flex-row md:flex-col gap-1.5 overflow-x-auto md:overflow-x-visible py-1 md:py-0 scrollbar-none">
              {tabs.map((tab) => {
                const IconComponent = tab.icon;
                const isActive = activeTab === tab.id;
                return (
                  <button
                    key={tab.id}
                    id={`sidebar-tab-${tab.id}`}
                    onClick={() => setActiveTab(tab.id)}
                    className={`flex items-center gap-3 px-4 py-2.5 rounded-xl text-xs font-mono uppercase tracking-wider transition-all relative cursor-pointer group shrink-0 ${
                      isActive 
                        ? 'text-[#00F2FE] bg-[#00F2FE]/10 border border-[#00F2FE]/20 shadow-[0_0_15px_rgba(0,242,254,0.05)]' 
                        : 'text-gray-400 hover:text-white hover:bg-white/[0.02] border border-transparent'
                    }`}
                  >
                    {isActive && (
                      <motion.div 
                        layoutId="activeTabIndicator"
                        className={`absolute top-0 bottom-0 w-1 bg-[#00F2FE] rounded-full ${isRtl ? 'right-0' : 'left-0'}`} 
                        transition={{ type: 'spring', stiffness: 300, damping: 30 }}
                      />
                    )}
                    <IconComponent className={`w-4 h-4 transition-colors ${isActive ? 'text-[#00F2FE]' : 'text-gray-500 group-hover:text-white'}`} />
                    <span>{tab.label}</span>
                  </button>
                );
              })}
            </div>
          </div>

          {/* Core QObject Properties Sidebar Metadata */}
          <div className="hidden md:flex flex-col gap-3 pt-6 border-t border-white/5 text-[10px] font-mono text-gray-500 uppercase tracking-wider">
            <div className="flex justify-between">
              <span>{content.labels.activeLanguage}:</span>
              <span className="text-[#00F2FE] font-bold">{currentLanguage.toUpperCase()}</span>
            </div>
            <div className="flex justify-between">
              <span>Orientation:</span>
              <span className="text-[#4FACFE] font-bold">{isRtl ? 'RTL' : 'LTR'}</span>
            </div>
            <div className="flex justify-between">
              <span>Memory Mapping:</span>
              <span className="text-emerald-400">HEAP_OK</span>
            </div>
          </div>
        </div>

        {/* B. Dynamic Content Stack */}
        <div className="flex-1 p-6 md:p-8 overflow-y-auto max-h-[580px] z-10 scrollbar-thin scrollbar-thumb-white/10 scrollbar-track-transparent">
          <AnimatePresence mode="wait">
            <motion.div
              key={activeTab + '_' + currentLanguage}
              initial={{ opacity: 0, x: isRtl ? -10 : 10 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: isRtl ? 10 : -10 }}
              transition={{ duration: 0.2 }}
              className="w-full h-full"
            >
              {/* PAGE 1: OVERVIEW */}
              {activeTab === 'overview' && (
                <div className="space-y-6">
                  {/* Glassmorphic Profile Card */}
                  <div className="p-6 rounded-2xl bg-white/[0.02] border border-white/5 shadow-lg relative overflow-hidden backdrop-blur-md">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-[#00F2FE]/10 to-[#4FACFE]/10 rounded-full blur-2xl pointer-events-none" />
                    
                    <div className="flex flex-col md:flex-row gap-6 items-center md:items-start text-center md:text-start">
                      {/* Avatar Mock with custom visual styling */}
                      <div className="relative shrink-0">
                        <div className="w-20 h-20 rounded-2xl bg-gradient-to-tr from-[#00F2FE] to-[#4FACFE] p-[1.5px] shadow-lg shadow-[#00F2FE]/20">
                          <div className="w-full h-full rounded-2xl bg-[#080810] flex items-center justify-center">
                            <span className="text-2xl font-bold font-mono text-transparent bg-clip-text bg-gradient-to-tr from-[#00F2FE] to-[#4FACFE]">
                              AR
                            </span>
                          </div>
                        </div>
                        <div className="absolute -bottom-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 border-2 border-[#0c0c16] flex items-center justify-center" title="Qt Runtime Online">
                          <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse" />
                        </div>
                      </div>

                      <div className="space-y-3 flex-1">
                        <div>
                          <h1 className="text-2xl font-bold text-white font-display">{content.name}</h1>
                          <p className="text-xs font-mono text-[#00F2FE] font-medium tracking-wider uppercase">{content.title}</p>
                        </div>
                        <p className="text-sm text-gray-300 leading-relaxed font-light">
                          {content.summary}
                        </p>
                      </div>
                    </div>
                  </div>

                  {/* Grid Contact Details & Call to Actions */}
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {/* Contact Chips Glass Panel */}
                    <div className="p-5 rounded-2xl bg-white/[0.02] border border-white/5 space-y-4">
                      <h3 className="text-[10px] font-mono uppercase tracking-widest text-gray-400 font-bold border-b border-white/5 pb-2">
                        System Contacts
                      </h3>
                      <div className="space-y-2.5">
                        <div className="flex items-center gap-3 text-sm text-gray-300">
                          <Mail className="w-4 h-4 text-[#00F2FE]" />
                          <span className="font-mono text-xs select-all text-gray-300">{content.contact.email}</span>
                        </div>
                        <div className="flex items-center gap-3 text-sm text-gray-300">
                          <MapPin className="w-4 h-4 text-[#00F2FE]" />
                          <span className="font-light">{content.contact.location}</span>
                        </div>
                        <div className="flex items-center gap-3 text-sm text-gray-300">
                          <Github className="w-4 h-4 text-[#00F2FE]" />
                          <a 
                            href={content.contact.github} 
                            target="_blank" 
                            rel="noopener noreferrer"
                            className="hover:text-[#00F2FE] hover:underline transition-colors inline-flex items-center gap-1 font-mono text-xs"
                          >
                            <span>github.com/alirezareisiminab</span>
                            <ExternalLink className="w-3 h-3" />
                          </a>
                        </div>
                      </div>
                    </div>

                    {/* Quick Access Targets */}
                    <div className="p-5 rounded-2xl bg-white/[0.02] border border-white/5 flex flex-col justify-between">
                      <div>
                        <h3 className="text-[10px] font-mono uppercase tracking-widest text-gray-400 font-bold border-b border-white/5 pb-2 mb-3">
                          {content.labels.desktopTargets}
                        </h3>
                        <p className="text-xs text-gray-400 leading-relaxed mb-4 font-light">
                          This portfolio is engineered in native Qt C++ and compiles as a high-performance application for both desktop operating systems and WebAssembly targets.
                        </p>
                      </div>
                      <div className="flex flex-wrap gap-2">
                        <span className="px-2.5 py-1 text-[9px] font-mono rounded-md bg-white/[0.02] border border-white/5 text-[#00F2FE] uppercase tracking-wider">Windows MinGW</span>
                        <span className="px-2.5 py-1 text-[9px] font-mono rounded-md bg-white/[0.02] border border-white/5 text-[#00F2FE] uppercase tracking-wider">Linux GCC</span>
                        <span className="px-2.5 py-1 text-[9px] font-mono rounded-md bg-white/[0.02] border border-white/5 text-[#00F2FE] uppercase tracking-wider">WASM STATIC</span>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* PAGE 2: EXPERIENCE */}
              {activeTab === 'experience' && (
                <div className="space-y-6">
                  <div className="flex items-center justify-between border-b border-white/5 pb-3">
                    <h3 className="text-xs font-mono uppercase tracking-widest text-[#00F2FE] font-bold flex items-center gap-2">
                      <Briefcase className="w-4 h-4 text-[#00F2FE]" />
                      <span>{content.labels.timeline}</span>
                    </h3>
                    <span className="text-[10px] font-mono text-gray-500 uppercase tracking-wider">QAbstractListModel Dynamic List</span>
                  </div>

                  {/* High fidelity timeline visualization */}
                  <div className="relative pl-6 pr-6 py-2 space-y-8">
                    {/* Glowing vertical line - shifts left/right depending on RTL */}
                    <div className={`absolute top-0 bottom-0 w-[1px] bg-gradient-to-b from-[#00F2FE]/60 via-[#4FACFE]/30 to-transparent ${isRtl ? 'right-6' : 'left-6'}`} />

                    {content.experience.map((item, index) => (
                      <div key={index} className="relative group">
                        {/* Timeline glowing dot */}
                        <div className={`absolute top-1.5 w-3 h-3 rounded-full bg-[#080810] border-2 border-[#00F2FE] shadow-lg shadow-[#00F2FE]/30 transition-transform group-hover:scale-125 duration-300 z-10 ${isRtl ? '-right-[23px]' : '-left-[23px]'}`} />

                        <div className="space-y-3 p-5 rounded-2xl bg-white/[0.01] border border-white/5 hover:border-white/10 transition-all duration-300">
                          {/* Role and Period bar */}
                          <div className="flex flex-col md:flex-row md:items-center justify-between gap-1.5">
                            <div>
                              <h4 className="text-base font-bold text-white font-display">{item.role}</h4>
                              <p className="text-xs font-mono text-[#00F2FE] font-medium tracking-wider uppercase">{item.company}</p>
                            </div>
                            <span className="px-3 py-1 rounded-md bg-white/[0.03] border border-white/5 text-gray-300 text-[10px] font-mono uppercase tracking-wider self-start md:self-center">
                              {item.period}
                            </span>
                          </div>

                          {/* Bullet points mapping */}
                          <ul className="space-y-2 text-sm text-gray-300 leading-relaxed list-none pl-0 font-light">
                            {item.description.map((bullet, idx) => (
                              <li key={idx} className="flex gap-2.5 items-start">
                                <CornerDownRight className={`w-3.5 h-3.5 mt-1 shrink-0 text-[#00F2FE] ${isRtl ? 'rotate-180' : ''}`} />
                                <span>{bullet}</span>
                              </li>
                            ))}
                          </ul>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* PAGE 3: SKILLS */}
              {activeTab === 'skills' && (
                <div className="space-y-6">
                  <div className="flex items-center justify-between border-b border-white/5 pb-3">
                    <h3 className="text-xs font-mono uppercase tracking-widest text-[#00F2FE] font-bold flex items-center gap-2">
                      <Cpu className="w-4 h-4 text-[#00F2FE]" />
                      <span>{content.labels.techStack}</span>
                    </h3>
                    <span className="text-[10px] font-mono text-gray-500 uppercase tracking-wider">C++ Struct Vectors Mapping</span>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {content.skills.map((category, catIndex) => (
                      <div key={catIndex} className="p-5 rounded-2xl bg-white/[0.02] border border-white/5 space-y-4">
                        <h4 className="text-xs font-bold text-white font-display tracking-widest uppercase flex items-center gap-2 border-b border-white/5 pb-2">
                          <span className="w-1.5 h-1.5 rounded-full bg-[#00F2FE]" />
                          {category.category}
                        </h4>
                        <div className="space-y-3.5">
                          {category.items.map((skill, sIndex) => (
                            <div key={sIndex} className="space-y-1.5">
                              <div className="flex justify-between text-[11px] font-mono text-gray-400">
                                <span className="font-medium text-white">{skill.name}</span>
                                <span className="text-[#00F2FE]">{skill.level}%</span>
                              </div>
                              {/* Glowing level gauge bar */}
                              <div className="h-1 w-full bg-black/40 rounded-full overflow-hidden border border-white/5">
                                <motion.div 
                                  initial={{ width: 0 }}
                                  animate={{ width: animateProgress ? `${skill.level}%` : '0%' }}
                                  transition={{ duration: 1, delay: sIndex * 0.1, ease: 'easeOut' }}
                                  className="h-full bg-gradient-to-r from-[#00F2FE] to-[#4FACFE] rounded-full shadow-[0_0_8px_rgba(0,242,254,0.4)]"
                                  style={{ transformOrigin: isRtl ? 'right' : 'left' }}
                                />
                              </div>
                            </div>
                          ))}
                        </div>
                      </div>
                    ))}

                    {/* Education section in skills panel */}
                    <div className="p-5 rounded-2xl bg-white/[0.02] border border-white/5 flex flex-col justify-between">
                      <div>
                        <h4 className="text-xs font-bold text-white font-display tracking-widest uppercase flex items-center gap-2 border-b border-white/5 pb-2 mb-3">
                          <span className="w-1.5 h-1.5 rounded-full bg-[#4FACFE]" />
                          Education History
                        </h4>
                        {content.education.map((edu, eIndex) => (
                          <div key={eIndex} className="space-y-2">
                            <div className="flex flex-col gap-1">
                              <h5 className="text-sm font-bold text-gray-200 font-display">{edu.degree}</h5>
                              <p className="text-xs font-mono text-[#00F2FE] font-medium tracking-wider uppercase">{edu.institution}</p>
                              <span className="text-[10px] font-mono text-gray-500 uppercase tracking-wider">{edu.period}</span>
                            </div>
                            <p className="text-xs text-gray-400 leading-relaxed font-light">
                              {edu.details}
                            </p>
                          </div>
                        ))}
                      </div>
                      <div className="mt-4 pt-3 border-t border-white/5 flex items-center gap-2 text-[10px] font-mono text-gray-500 uppercase tracking-widest">
                        <FileCode className="w-3.5 h-3.5 text-gray-500" />
                        <span>Registered as Q_GADGET structures</span>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* PAGE 4: CONTACT */}
              {activeTab === 'contact' && (
                <div className="space-y-6">
                  <div className="flex items-center justify-between border-b border-white/5 pb-3">
                    <h3 className="text-xs font-mono uppercase tracking-widest text-[#00F2FE] font-bold flex items-center gap-2">
                      <Mail className="w-4 h-4 text-[#00F2FE]" />
                      <span>{content.labels.contact}</span>
                    </h3>
                    <span className="text-[10px] font-mono text-gray-500 uppercase tracking-wider">Qt Custom Form Event Receiver</span>
                  </div>

                  <div className="max-w-xl mx-auto p-6 rounded-2xl bg-white/[0.01] border border-white/5 relative">
                    {/* Background glows */}
                    <div className="absolute top-0 right-0 w-20 h-20 bg-[#4FACFE]/5 rounded-full blur-xl pointer-events-none" />

                    <form onSubmit={handleFormSubmit} className="space-y-4">
                      {/* Form Header info */}
                      <p className="text-xs text-gray-400 leading-relaxed mb-1 font-light">
                        Submit a message to dispatch a simulated QObject signal in the Qt process, representing dynamic C++ form validation and networking handlers.
                      </p>

                      {/* Name Field */}
                      <div className="space-y-1.5">
                        <label className="text-[10px] font-mono text-gray-400 font-bold uppercase tracking-wider">{content.labels.nameField}</label>
                        <input 
                          type="text" 
                          value={formName}
                          onChange={(e) => setFormName(e.target.value)}
                          placeholder="Alireza" 
                          disabled={formStatus === 'sending' || formStatus === 'success'}
                          className="w-full px-3.5 py-2.5 text-sm bg-black/40 border border-white/5 focus:border-[#00F2FE]/50 text-white rounded-xl outline-none transition-all placeholder:text-gray-600 font-sans font-light"
                        />
                      </div>

                      {/* Email Field */}
                      <div className="space-y-1.5">
                        <label className="text-[10px] font-mono text-gray-400 font-bold uppercase tracking-wider">{content.labels.emailField}</label>
                        <input 
                          type="email" 
                          value={formEmail}
                          onChange={(e) => setFormEmail(e.target.value)}
                          placeholder="client@qml-network.org" 
                          disabled={formStatus === 'sending' || formStatus === 'success'}
                          className="w-full px-3.5 py-2.5 text-sm bg-black/40 border border-white/5 focus:border-[#00F2FE]/50 text-white rounded-xl outline-none transition-all placeholder:text-gray-600 font-mono font-light"
                        />
                      </div>

                      {/* Message Field */}
                      <div className="space-y-1.5">
                        <label className="text-[10px] font-mono text-gray-400 font-bold uppercase tracking-wider">{content.labels.msgField}</label>
                        <textarea 
                          rows={3}
                          value={formMessage}
                          onChange={(e) => setFormMessage(e.target.value)}
                          placeholder="..." 
                          disabled={formStatus === 'sending' || formStatus === 'success'}
                          className="w-full px-3.5 py-2.5 text-sm bg-black/40 border border-white/5 focus:border-[#00F2FE]/50 text-white rounded-xl outline-none transition-all placeholder:text-gray-600 resize-none font-sans font-light"
                        />
                      </div>

                      {/* Form Response Indicators */}
                      <AnimatePresence mode="wait">
                        {formStatus !== 'idle' && (
                          <motion.div 
                            initial={{ opacity: 0, y: -5 }}
                            animate={{ opacity: 1, y: 0 }}
                            exit={{ opacity: 0, y: -5 }}
                            className={`p-3.5 rounded-xl flex items-center gap-2.5 text-xs font-mono border ${
                              formStatus === 'sending' 
                                ? 'bg-[#00F2FE]/10 border-[#00F2FE]/20 text-[#00F2FE]' 
                                : formStatus === 'success'
                                  ? 'bg-emerald-500/10 border-emerald-500/20 text-emerald-400'
                                  : 'bg-rose-500/10 border-rose-500/20 text-rose-400'
                            }`}
                          >
                            {formStatus === 'sending' && (
                              <Activity className="w-4 h-4 text-[#00F2FE] animate-spin" />
                            )}
                            {formStatus === 'success' && (
                              <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
                            )}
                            {formStatus === 'error' && (
                              <AlertCircle className="w-4 h-4 text-rose-400 shrink-0" />
                            )}
                            <span>{statusText}</span>
                          </motion.div>
                        )}
                      </AnimatePresence>

                      {/* Submit Button */}
                      <button
                        type="submit"
                        disabled={formStatus === 'sending' || formStatus === 'success'}
                        className={`w-full py-3 rounded-xl text-xs font-mono uppercase tracking-widest font-bold flex items-center justify-center gap-2 cursor-pointer transition-all ${
                          formStatus === 'success'
                            ? 'bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 cursor-not-allowed'
                            : formStatus === 'sending'
                              ? 'bg-[#00F2FE]/10 border border-[#00F2FE]/20 text-[#00F2FE] cursor-not-allowed'
                              : 'bg-gradient-to-r from-[#00F2FE] to-[#4FACFE] text-[#080810] hover:shadow-[0_0_20px_rgba(0,242,254,0.3)] shadow-lg active:scale-[0.99]'
                        }`}
                      >
                        <Send className="w-4 h-4" />
                        <span>{content.labels.sendMsg}</span>
                      </button>
                    </form>
                  </div>
                </div>
              )}
            </motion.div>
          </AnimatePresence>
        </div>
      </div>
    </div>
  );
}
