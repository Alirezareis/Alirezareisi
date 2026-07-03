import { DualLanguageResume } from '../types';

export const resumeData: DualLanguageResume = {
  en: {
    name: "Alireza Reisiminab",
    title: "Senior Qt/C++ & Embedded Systems Engineer",
    summary: "High-caliber C++ developer specializing in cross-platform GUI engineering with Qt 6 QML, embedded software development, and WebAssembly. Adept at building memory-efficient, hardware-accelerated user interfaces, custom graphics rendering pipelines, and real-time backend systems. Proven track record of compiling and deploying mission-critical software across Windows, Linux, Android, and web runtimes via Emscripten.",
    contact: {
      email: "alirezareisiminab.imortal.1381@gmail.com",
      github: "https://github.com/alirezareisiminab",
      location: "Tehran, Iran",
      website: "https://alirezareisiminab.dev",
      telegram: "@alirezareisiminab"
    },
    experience: [
      {
        company: "Vira Tech Solutions",
        role: "Lead Qt/C++ Engineer",
        period: "2024 - Present",
        description: [
          "Led development of a high-performance cross-platform desktop suite for sensor telemetry data visualization using Qt Quick, QML, and C++.",
          "Architected custom hardware-accelerated OpenGL/Vulkan rendering nodes inside QML Scene Graph to render 60 FPS real-time 3D signal streams.",
          "Cross-compiled the legacy desktop application to WebAssembly using Emscripten, decreasing initial page load sizes by 40% and optimizing single-threaded Canvas performance.",
          "Established automated GitHub Actions pipelines to build and deploy desktop targets (Windows MinGW, Linux GCC) and web bundles (WASM) simultaneously."
        ]
      },
      {
        company: "Saba Industrial Systems",
        role: "Senior C++ & QML Developer",
        period: "2022 - 2024",
        description: [
          "Developed embedded user interfaces (HMIs) for medical equipment running on custom ARM-based Linux boards using Qt Quick and C++ APIs.",
          "Optimized RAM utilization from 250MB to 78MB by implementing strict C++ Qt models (QAbstractListModel) and lazy-loading heavy QML assets.",
          "Designed and implemented a custom RTL (Right-to-Left) localization subsystem to seamlessly switch between English and Persian without resetting device states.",
          "Integrated serial communication protocols (Modbus, CAN bus) via C++ worker threads communicating asynchronously with QML presentation layers."
        ]
      },
      {
        company: "Rayandish Software House",
        role: "C++ Software Developer",
        period: "2020 - 2022",
        description: [
          "Maintained and refactored enterprise database applications using Qt Widgets, C++, and PostgreSQL.",
          "Reduced database query overhead by 35% by implementing multithreaded queries via QtConcurrent and custom QThread workers.",
          "Designed polished custom controls and stylesheets (QSS) for legacy medical diagnostics software, improving usability scores by 50%."
        ]
      }
    ],
    skills: [
      {
        category: "C++ & Systems Programming",
        items: [
          { name: "C++ (11/14/17/20/23)", level: 95 },
          { name: "STL & Template Metaprogramming", level: 90 },
          { name: "Multithreading & Concurrency", level: 92 },
          { name: "Memory Management & Profiling (Valgrind)", level: 88 }
        ]
      },
      {
        category: "Qt Framework & QML",
        items: [
          { name: "Qt Quick / QML / Scene Graph", level: 96 },
          { name: "Qt Core & Qt Network APIs", level: 92 },
          { name: "QAbstractItemModel Integration", level: 94 },
          { name: "Qt Widgets & Custom Styling", level: 85 }
        ]
      },
      {
        category: "WebAssembly & Toolchains",
        items: [
          { name: "Emscripten & Qt for WASM", level: 90 },
          { name: "CMake / QMake / Ninja", level: 88 },
          { name: "GCC / Clang / MSVC Compilers", level: 92 },
          { name: "Git & CI/CD Pipelines", level: 85 }
        ]
      }
    ],
    education: [
      {
        institution: "Amirkabir University of Technology (Tehran Polytechnic)",
        degree: "Bachelor of Science in Software Engineering",
        period: "2019 - 2023",
        details: "Specialized in High-Performance Computing and Embedded Software Architectures. Capstone Project: Development of a multi-threaded embedded telemetry visualizer using Qt Quick."
      }
    ],
    labels: {
      overview: "Overview",
      experience: "Experience",
      skills: "Skills & Stack",
      contact: "Get in Touch",
      downloadDesktop: "Get Desktop Builds",
      windowsBuild: "Windows x64 Build (MinGW)",
      linuxBuild: "Linux x64 Build (AppImage)",
      wasmBuild: "WebAssembly Qt 6.7 Target",
      switchLang: "فارسی (Persian)",
      timeline: "Professional Timeline",
      techStack: "Technical Armament",
      sendMsg: "Send QML-Validated Message",
      nameField: "Your Name",
      emailField: "Your Email Address",
      msgField: "Message Content",
      sending: "Dispatching C++ thread...",
      sentSuccess: "Message serialized & transmitted successfully! QObject signal received.",
      sentError: "Invalid inputs detected. Check your form parameters.",
      copyCode: "Copy Code",
      copied: "Copied!",
      cppBackend: "C++ Backend Controller",
      qmlFrontend: "QML Adaptive UI",
      ciCdWorkflow: "CI/CD Build Pipeline",
      qtVersion: "Qt 6.7 LTS Profile",
      webAssemblyCanvas: "Interactive WebAssembly Sandbox (Live Qt QML Model)",
      desktopTargets: "Compile Targets",
      activeLanguage: "Active Engine Language"
    }
  },
  fa: {
    name: "علیرضا رییسی میناب",
    title: "مهندس ارشد Qt/C++ و سیستم‌های نهفته (Embedded)",
    summary: "برنامه‌نویس باسابقه C++ متخصص در مهندسی رابط کاربری چندسکویی با Qt 6 QML، توسعه نرم‌افزارهای سیستم‌های نهفته و وب‌اسمبلی (WebAssembly). ماهر در ساخت رابط‌های گرافیکی بهینه از نظر حافظه، شتاب‌دهی سخت‌افزاری، پایپ‌لاین‌های رندرینگ اختصاصی و سیستم‌های بک‌اند بی‌درنگ (Real-time). دارای سابقه درخشان در کامپایل و استقرار نرم‌افزارهای حیاتی بر روی ویندوز، لینوکس، اندروید و مرورگرها با استفاده از Emscripten.",
    contact: {
      email: "alirezareisiminab.imortal.1381@gmail.com",
      github: "https://github.com/alirezareisiminab",
      location: "تهران، ایران",
      website: "https://alirezareisiminab.dev",
      telegram: "@alirezareisiminab"
    },
    experience: [
      {
        company: "راهکارهای فناوران ویرا",
        role: "مهندس ارشد Qt/C++",
        period: "۱۴۰۳ - اکنون",
        description: [
          "رهبری فرآیند توسعه یک پکیج دسکتاپ چندسکویی با کارایی بالا برای تصویرسازی داده‌های تلمتری حسگرها با استفاده از Qt Quick، QML و C++.",
          "معماری نودهای رندرینگ سفارشی با شتاب‌دهی سخت‌افزاری OpenGL/Vulkan درون QML Scene Graph جهت نمایش جریان‌های سیگنال ۳بعدی با سرعت ۶۰ فریم بر ثانیه.",
          "کروس-کامپایل نرم‌افزار دسکتاپ قدیمی به وب‌اسمبلی (WebAssembly) با Emscripten، کاهش ۴۰ درصدی حجم بارگذاری اولیه و بهینه‌سازی عملکرد تک‌رشته‌ای Canvas.",
          "ایجاد پایپ‌لاین‌های خودکار GitHub Actions برای ساخت و انتشار همزمان نسخه‌های دسکتاپ (ویندوز MinGW، لینوکس GCC) و وب‌اسمبلی (WASM)."
        ]
      },
      {
        company: "سیستم‌های صنعتی صبا",
        role: "برنامه‌نویس ارشد C++ و QML",
        period: "۱۴۰۱ - ۱۴۰۳",
        description: [
          "توسعه رابط کاربری سیستم‌های مانیتورینگ پزشکی (HMI) روی بردهای اختصاصی لینوکس مبتنی بر پردازنده‌های ARM با استفاده از سیستم Qt Quick و C++ API.",
          "بهینه‌سازی استفاده از حافظه رم (RAM) از ۲۵۰ مگابایت به ۷۸ مگابایت از طریق پیاده‌سازی مدل‌های ساختاریافته C++ (کلاس QAbstractListModel) و بارگذاری تنبل (Lazy Loading) دارایی‌های گرافیکی سنگین QML.",
          "طراحی و پیاده‌سازی زیرسیستم بومی‌سازی راست‌به‌چپ (RTL) به صورت پویا برای سوییچ آنی میان زبان‌های انگلیسی و فارسی بدون نیاز به ریستارت کردن وضعیت دستگاه.",
          "پیاده‌سازی پروتکل‌های ارتباطی سریال (Modbus، CAN bus) از طریق ترد‌های پس‌زمینه C++ که به صورت غیرهمگام با لایه نمایش QML ارتباط برقرار می‌کنند."
        ]
      },
      {
        company: "شرکت نرم‌افزاری رای‌اندیش",
        role: "برنامه‌نویس C++",
        period: "۱۳۹۹ - ۱۴۰۱",
        description: [
          "نگهداری و بازطراحی سیستم‌های پایگاه داده سازمانی با استفاده از ابزار Qt Widgets، C++ و PostgreSQL.",
          "کاهش ۳۵ درصدی تاخیر پرس‌وجوهای پایگاه داده با پیاده‌سازی مکانیزم‌های چندرشته‌ای از طریق QtConcurrent و کلاس‌های اختصاصی QThread.",
          "طراحی کنترل‌های سفارشی مدرن و استایل‌دهی پیشرفته (QSS) برای نرم‌افزارهای قدیمی تشخیص پزشکی که منجر به افزایش ۵۰ درصدی شاخص رضایت کاربری شد."
        ]
      }
    ],
    skills: [
      {
        category: "برنامه‌نویسی سیستم و C++",
        items: [
          { name: "C++ (11/14/17/20/23)", level: 95 },
          { name: "STL & Template Metaprogramming", level: 90 },
          { name: "Multithreading & Concurrency", level: 92 },
          { name: "Memory Management & Profiling (Valgrind)", level: 88 }
        ]
      },
      {
        category: "فریمورک Qt و QML",
        items: [
          { name: "Qt Quick / QML / Scene Graph", level: 96 },
          { name: "Qt Core & Qt Network APIs", level: 92 },
          { name: "QAbstractItemModel Integration", level: 94 },
          { name: "Qt Widgets & Custom Styling", level: 85 }
        ]
      },
      {
        category: "وب‌اسمبلی و ابزارهای توسعه",
        items: [
          { name: "Emscripten & Qt for WASM", level: 90 },
          { name: "CMake / QMake / Ninja", level: 88 },
          { name: "GCC / Clang / MSVC Compilers", level: 92 },
          { name: "Git & CI/CD Pipelines", level: 85 }
        ]
      }
    ],
    education: [
      {
        institution: "دانشگاه صنعتی امیرکبیر (پلی‌تکنیک تهران)",
        degree: "کارشناسی مهندسی نرم‌افزار",
        period: "۱۳۹۸ - ۱۴۰۲",
        details: "گرایش محاسبات با کارایی بالا (HPC) و معماری‌های نرم‌افزار تعبیه‌شده (Embedded). پروژه پایانی: توسعه تصویرساز بلادرنگ تلمتری تعبیه‌شده با چندرشته‌ای غیرهمگام در Qt Quick."
      }
    ],
    labels: {
      overview: "معرفی کلی",
      experience: "سوابق کاری",
      skills: "مهارت‌ها و تخصص",
      contact: "ارتباط با من",
      downloadDesktop: "دریافت نسخه دسکتاپ",
      windowsBuild: "نسخه ویندوز x64 (MinGW)",
      linuxBuild: "نسخه لینوکس x64 (AppImage)",
      wasmBuild: "نسخه وب‌اسمبلی Qt 6.7",
      switchLang: "English (انگلیسی)",
      timeline: "گاه‌شمار شغلی",
      techStack: "زرادخانه فنی و مهارت‌ها",
      sendMsg: "ارسال پیام تاییدشده در QML",
      nameField: "نام شما",
      emailField: "آدرس ایمیل شما",
      msgField: "متن پیام",
      sending: "درحال تخصیص نخ C++...",
      sentSuccess: "پیام با موفقیت سریالیزه و ارسال شد! سیگنال QObject دریافت گردید.",
      sentError: "ورودی‌های نامعتبر شناسایی شدند. پارامترهای فرم را مجدداً بررسی کنید.",
      copyCode: "کپی کردن کد",
      copied: "کپی شد!",
      cppBackend: "کنترل‌کننده پس‌زمینه C++",
      qmlFrontend: "رابط کاربری تطبیق‌پذیر QML",
      ciCdWorkflow: "پایپ‌لاین ساخت خودکار CI/CD",
      qtVersion: "پروفایل Qt 6.7 LTS",
      webAssemblyCanvas: "محیط وب‌اسمبلی تعاملی (مدل زنده Qt QML)",
      desktopTargets: "اهداف کامپایل دسکتاپ",
      activeLanguage: "زبان فعال موتور پردازش"
    }
  }
};
