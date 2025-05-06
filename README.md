# Godot-Logic-Sim
A logic gate simulator with godot engine

A visual and interactive logic gate simulator built with the Godot Engine. This project allows users to design, simulate, and test digital logic circuits using drag-and-drop gates and wire connections.

## 🎯 Features

- 🧱 Basic logic gates: "AND, OR, NOT,NAND" for now..
- 
- 🖱️ Drag-and-drop interface for placing and connecting gates
- 
- 🔌 Real-time signal propagation between connected nodes
- 
- 🧠 Custom logic circuits creation and simulation
- 
- 🖼️ Multi-select and copy-paste functionality for efficient editing
 
- 📦 Modular and scalable codebase for future enhancements


## 🚀 Getting Started

### Requirements

- [Godot Engine 4.x](https://godotengine.org/download) (latest stable version)

### Running the Project

1. Clone the repository:

Open the project in Godot.

Run the scene Main.tscn.

🛠️ Tech Stack
Engine: Godot 4.2.1

Language: GDScript

Platform: Cross-platform (Windows, Linux, macOS)

📚 How It Works
Each gate is a custom Node2D with input/output ports.

Signals propagate through connected wires based on gate logic.

Users can connect gates visually by drawing cables between ports.


📌 Roadmap
 Add "Gates packaging" to more modular and  fun experience(For example making D flip-flop with gates from scratch and packaging it to use it again)

 Save/Load circuit functionality

 Better Interface

 More components...


 Controls:
  ."Left click" on logic gates in the left panel to  instatiate them.
  
  ."Right Click+drag" to highligh gate or gate groups to be able to drag,copy,paste or delete them.
  
  ."Delete" to delete the gates after higlighting them.
  
  ."Mouse Left Button HOLD " to drag gates or gate groups. 
  
  ."Right Click" on logic output ports to drag wire from them.
  
  ."Right Click" again on input ports to terminate wiring.
  
  ."CTRL+c" to copy node or node groups.
  
  ."CTRL+v" or "mouse wheel click" to paste gate or gate groups,

🤝 Contributing
Contributions are welcome! Feel free to fork this repo and submit a pull request. For major changes, please open an issue first to discuss your ideas.

📄 License
This project is licensed under the MIT License. See the LICENSE file for details.
