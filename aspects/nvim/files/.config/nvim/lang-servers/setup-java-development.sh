#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim"

# Install eclipse-java-google-style.xml
rm -rf "$INSTALL_FOLDER/eclipse-java-google-style.xml"
curl https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml --output "$INSTALL_FOLDER/eclipse-java-google-style.xml"

# Install java-debug
rm -rf "$INSTALL_FOLDER/java-debug"
git clone https://github.com/microsoft/java-debug.git "$INSTALL_FOLDER/java-debug"
cd "$INSTALL_FOLDER/java-debug" && ./mvnw clean install

# Install vscode-java-test
rm -rf "$INSTALL_FOLDER/vscode-java-test"
git clone https://github.com/microsoft/vscode-java-test.git "$INSTALL_FOLDER/vscode-java-test"
cd "$INSTALL_FOLDER/vscode-java-test" && npm install && npm run build-plugin
