import sys
import magic

def main(n=5):
    
    # Start a matlab engine
    eng = magic.initialize()
    # Compute the magic square
    square = eng.makesqr(n)
    # Print it with each row on a separate line
    print("\n".join([str(s) for s in square]))
    # Shut down the matlab engine
    eng.terminate()

if __name__ == "__main__":

    print(sys.argv)
    if len(sys.argv) > 1:
        main(int(sys.argv[1]))
    else:
        main()
