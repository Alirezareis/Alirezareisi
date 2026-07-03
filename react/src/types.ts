export interface ContactInfo {
  email: string;
  github: string;
  location: string;
  website: string;
  telegram?: string;
}

export interface ExperienceItem {
  company: string;
  role: string;
  period: string;
  description: string[];
}

export interface SkillItem {
  name: string;
  level: number; // 0 to 100
}

export interface SkillCategory {
  category: string;
  items: SkillItem[];
}

export interface EducationItem {
  institution: string;
  degree: string;
  period: string;
  details?: string;
}

export interface ResumeContent {
  name: string;
  title: string;
  summary: string;
  contact: ContactInfo;
  experience: ExperienceItem[];
  skills: SkillCategory[];
  education: EducationItem[];
  labels: {
    overview: string;
    experience: string;
    skills: string;
    contact: string;
    downloadDesktop: string;
    windowsBuild: string;
    linuxBuild: string;
    wasmBuild: string;
    switchLang: string;
    timeline: string;
    techStack: string;
    sendMsg: string;
    nameField: string;
    emailField: string;
    msgField: string;
    sending: string;
    sentSuccess: string;
    sentError: string;
    copyCode: string;
    copied: string;
    cppBackend: string;
    qmlFrontend: string;
    ciCdWorkflow: string;
    qtVersion: string;
    webAssemblyCanvas: string;
    desktopTargets: string;
    activeLanguage: string;
  };
}

export interface DualLanguageResume {
  en: ResumeContent;
  fa: ResumeContent;
}

export interface CodeFile {
  name: string;
  path: string;
  language: 'cpp' | 'qml' | 'json' | 'yaml' | 'pro';
  content: string;
  description: string;
}
