import requests, os
from zipfile import ZipFile

requirement : dict = {
    'GodotSteam_v4.12' : {
        'name' : 'GodotSteam_v4.12',
        'version' : 4.12,
        'link' : 'https://github.com/GodotSteam/GodotSteam/releases/download/v4.12/win64-g43-s161-gs412-d3d12.zip',
        'description' : 'Steamworks module for Godot Engine',
        'location' : 'Launcher/GodotSteam4.12/'
        
    }
}




def DownloadAndInstall(requirement : dict):
    print(f'Downloading {requirement["name"]}...')
    file = requests.get(requirement['link'])
    
    with open(f'temp/{requirement["name"]}.zip', 'wb') as f:
        f.write(file.content)
        
    with ZipFile(f'temp/{requirement["name"]}.zip', 'r') as zipFile:
        zipFile.extractall(requirement["location"])

    print(f'{requirement["name"]} downloaded and installed successfully')
    
    # remove the file from temp
    os.remove(f'temp/{requirement["name"]}.zip')
    
    
def main():
    DownloadAndInstall(requirement['GodotSteam_v4.12'])
    
if __name__ == '__main__':
    main()