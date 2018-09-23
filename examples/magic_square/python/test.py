import sys
import magic

def main(n=5):
    
    eng = magic.initialize()
    square = eng.makesqr(n)
    print("\n".join([str(s) for s in square]))
    eng.terminate()

if __name__ == "__main__":

    print(sys.argv)
    if len(sys.argv) > 1:
        main(int(sys.argv[1]))
    else:
        main()
