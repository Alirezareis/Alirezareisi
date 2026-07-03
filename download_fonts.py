import urllib.request
import zipfile
import os
import ssl

ssl._create_default_https_context = ssl._create_unverified_context

families = ["Inter", "Space%20Grotesk", "JetBrains%20Mono"]

os.makedirs("assets/fonts/temp", exist_ok=True)

for family in families:
    url = f"https://fonts.google.com/download?family={family}"
    zip_path = f"assets/fonts/temp/{family}.zip"
    print(f"Downloading {family}...")
    try:
        urllib.request.urlretrieve(url, zip_path)
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            # Extract only .ttf files
            for file in zip_ref.namelist():
                if file.endswith('.ttf'):
                    # Extract to temp
                    zip_ref.extract(file, "assets/fonts/temp")
                    # Move to fonts folder (flatten)
                    import shutil
                    src = os.path.join("assets/fonts/temp", file)
                    dst = os.path.join("assets/fonts", os.path.basename(file))
                    shutil.move(src, dst)
        print(f"Successfully downloaded and extracted {family}")
    except Exception as e:
        print(f"Failed to download {family}: {e}")

# Cleanup
import shutil
shutil.rmtree("assets/fonts/temp", ignore_errors=True)
