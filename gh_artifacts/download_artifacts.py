import os
import json

gh_token = # add github token here
gh_repo = 'https://api.github.com/repos/lucapegolotti/SVExternals/actions/artifacts'

zip_prefix = 'ubuntu.20.04.gnu.7.5.x64.release.2022.10.13.'

if __name__ == "__main__":
    command = 'curl -L -H "Accept: application/vnd.github+json" '
    command += '-H "Authorization: Bearer {:}" '.format(gh_token)
    command += '-H "X-GitHub-Api-Version: 2022-11-28" '
    command += '{:} > artifacts.json'.format(gh_repo)
    os.system(command)

    artinfo = json.load(open('artifacts.json'))
    
    art_dict = {}

    for ext in artinfo['artifacts']:
        if ext['name'] not in art_dict:
            art_dict[ext['name']] = ext
        else:
            # if the current artifact has been created after the stored one,
            # we updatels it
            if ext['updated_at'] > art_dict[ext['name']]['updated_at']:
                art_dict[ext['name']] = ext

    os.system('rm artifacts.json')

    for art_name, art_value in art_dict.items():
        file_name = art_name.replace(' ','-').lower()
        command = 'curl -L -H "Accept: application/vnd.github+json" '
        command += '-H "Authorization: Bearer {:}" '.format(gh_token)
        command += '-H "X-GitHub-Api-Version: 2022-11-28" '
        command += '{:}/{:}/zip --output {:}.zip'.format(gh_repo, 
                                                         art_value['id'],
                                                         file_name)
        os.system(command)
        os.system('unzip {:}.zip'.format(file_name))
        for f in os.listdir('.'):
            if '.tar' in f:
                os.system('tar -xf {:}'.format(f))
                os.system('rm {:}'.format(f))
                break
        os.system('rm {:}.zip'.format(file_name))

    # this is temporary. We create a tar with a name compatible with what is
    # already on tetra
    for lib in os.listdir('.'):
        if '.json' not in lib and '.py' not in lib:
            tar_name = zip_prefix + lib.replace('-','.') + '.tar.gz'
            os.system('tar -czvf {:} {:}'.format(tar_name, lib))
            os.system('rm -rf {:}'.format(lib))


        





    