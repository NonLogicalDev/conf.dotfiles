from subprocess import call

def main():
    out, err = call(['tmux', 'list-windows'])

if __name__ == "__main__":
    main()
