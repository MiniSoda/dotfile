#!/usr/bin/python3

import os
import re
import subprocess
import json

compile_db_name = 'compile_commands.json'
compile_commands = []

compiler_dict = {}
sysroot_dict = {}


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def read_compile_commands():
  global compile_commands
  cwd = os.getcwd()
  path = os.path.join( cwd, compile_db_name)

  with open(path, 'r') as fp:
    compile_commands = json.load(fp)
  return


def handle_flags():
  gxx_path = ''
  sysroot = ''
  global compile_commands

  #make relative path abusolute
  working_directory = DirectoryOfThisScript()

  for command in compile_commands:
    info = 'Processing file: ' + command['file']
    print(info)

    compile_string = command["command"]
    compile_data = compile_string.split() #split string into a list

    for flag in compile_data: 
      if 'arm-buildroot-linux-gnueabihf-g' in flag:
          gxx_path = flag
          if gxx_path:
              sysroot = Load_System_Root(gxx_path)
          break

    compile_data = MakeRelativePathsInFlagsAbsolute(compile_data,command["directory"])

    flags = []          
    flags.append('-target')
    flags.append('arm-linux-gnueabihf')

    flags.append('--sysroot')
    flags.append(sysroot.rstrip())

    flags += Load_System_Includes( gxx_path )
    
    try:
      compile_data.remove( '-Wno-psabi' )
      #compile_data.remove( 'ccache' )
    except ValueError:
      pass
    
    index = compile_data.index(gxx_path) + 1
    compile_data[index:index] = flags
    
    seperator = ' '
    command["command"] = seperator.join(compile_data)
  
  return


def write_compile_commands():
  cwd = os.getcwd()
  path = os.path.join( cwd, compile_db_name)

  with open(path, 'w') as outfile:  
    json.dump(compile_commands, outfile, indent=4, sort_keys=True)
  return
   

def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )

  gxx_path = ''
  sysroot = ''
    
  for flag in flags: 
    if 'arm-buildroot-linux-gnueabihf-g' in flag:
        gxx_path = flag
        if gxx_path:
            sysroot = Load_System_Root(gxx_path)
        break
  
  # search path for some libs
  new_flags = []

  make_next_absolute = False
  # path_flags = [ '-isystem', '-I' ]
  path_flags = [ '-isystem' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )
      if flag.startswith( '=' ):
        new_flag = os.path.join( sysroot.rstrip(), flag[2:] )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  # log_file.close()
  return new_flags


def Load_System_Includes( gxx_path ):
  global compiler_dict
  if gxx_path in compiler_dict:
    return compiler_dict[gxx_path]
  else:
    regex = re.compile(r'(?:\#include \<...\> search starts here\:)(?P<list>.*?)(?:End of search list)', re.DOTALL)
    
    if 'gcc' in gxx_path:
      flag = 'c'
    else:
      flag = 'c++'

    process = subprocess.Popen([gxx_path, '-v', '-E', '-x', flag, '-'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    process_out, process_err = process.communicate('')
    output = process_out + process_err
    
    outputs = []
    for p in re.search( regex, output.decode("utf-8") ).group('list').split('\n'):
      p = p.strip()
      # if 'gcc' in p:
      #     continue
      if len(p) > 0 and p.find('(framework directory)') < 0:
        outputs.append('-isystem')
        outputs.append(p)
    compiler_dict[gxx_path] = outputs
    return outputs


def Load_System_Root( gxx_path ):
  global sysroot_dict
  if gxx_path in sysroot_dict:
    return sysroot_dict[gxx_path]
  else:
    cmd = gxx_path + ' -print-sysroot'    
    sysroot = os.popen(cmd).read()
    sysroot_dict[gxx_path] = sysroot
    return sysroot


def main():
  read_compile_commands()
  handle_flags()
  write_compile_commands()
  return


if __name__ == "__main__":
    # execute only if run as a script
    main()