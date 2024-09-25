import React from 'react';
import { View, StyleSheet, Text } from 'react-native';
import QRScanner from './qrcodescanner';

const App: React.FC = () => {
  return (
    <View style={styles.container}>
        <Text>"Loading..."</Text>
      <QRScanner />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  debugText: {
    fontSize: 18,
    marginBottom: 20,
  },
});

export default App;