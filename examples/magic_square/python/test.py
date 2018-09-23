"""
Remember to first source venv/bin/activate if the parent directory.
"""
import magic
eng = magic.initialize()
square = eng.makesqr(5)
print("\n".join([str(s) for s in square]))
eng.terminate()
