import subprocess, os

class Executor(object):
    def __init__(self,showErr=True,showOutput=True,showCmd=False):
        self.showCmd=showCmd
        if showErr: self.stderr = None 
        else: self.stderr=open(os.devnull,"w")
        if showOutput: self.stdout = None 
        else: self.stdout=open(os.devnull,"w")

    def __call__(self,*cmd):
        """ 
        Execute a program, e.g. Executor()("/bin/ls","/home")
        @cmd Command, args
        @return boolean True if succeed
        """
        if self.showCmd:
            print cmd
        return (subprocess.Popen(list(cmd),stderr=self.stderr,
                stdout=self.stdout).wait() == 0)

