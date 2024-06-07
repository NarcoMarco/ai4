import hashlib

def hash_text(text):
    md5_hash = hashlib.md5()

    md5_hash.update(text.encode('utf-8'))

    hex_digest = md5_hash.hexdigest()

    return hex_digest

print("Enter the password to gain access to the flag!")
input = input()
password = "1054b208a912f0f296e32e1bfb45c097"

flag = "supercoolflag435"

if hash_text(input) == password:
    print(f"cbrc_CTF({hash_text(flag)})")
else:
    print("Wrong password!")
