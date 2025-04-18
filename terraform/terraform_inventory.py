import json
import subprocess
import os

# شغّل terraform output -json وخزن الناتج
output = subprocess.check_output(['terraform', 'output', '-json'])
data = json.loads(output)

# docker_ip = data['docker_instance_ip']['value']
eks_ip = data['eks_worker_ip']['value']

# 🧠 حدد مسار السكريبت الحالي
script_dir = os.path.dirname(os.path.abspath(__file__))

# 📁 اطلع خطوة واحدة لفوق، وروّح لـ ansible folder
inventory_path = os.path.join(script_dir, "..", "ansible", "inventory.ini")

# ✍️ اكتب ملف inventory.ini في المكان الجديد
with open(inventory_path, "w") as f:
    f.write(f"""
[eks]
eks-master ansible_host={eks_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/eslam/Desktop/second_level/boardgame-app/ansible/aws-key.pem
""")
