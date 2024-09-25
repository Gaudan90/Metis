import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, Button, Alert } from 'react-native';
import { Camera } from 'react-native-camera';

const QRCodeScanner = () => {
  const [hasPermission, setHasPermission] = useState(null);
  const [scanned, setScanned] = useState(false);

  useEffect(() => {
    (async () => {
      const { status } = await Camera.requestPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  const handleBarCodeScanned = ({ type, data }) => {
    setScanned(true);
    Alert.alert('QR Code Scansionato', `Tipo: ${type}\nDati: ${data}`);
  };

  if (hasPermission === null) {
    return <Text>Richiesta permesso per la fotocamera...</Text>;
  }
  if (hasPermission === false) {
    return <Text>Accesso alla fotocamera negato</Text>;
  }

  return (
    <View style={styles.container}>
      <Camera
        style={styles.camera}
        onBarCodeScanned={scanned ? undefined : handleBarCodeScanned}
      >
        <View style={styles.overlay}>
          <Text style={styles.scanText}>Inquadra un QR Code</Text>
        </View>
      </Camera>
      {scanned && (
        <Button title="Scansiona di nuovo" onPress={() => setScanned(false)} />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
  },
  camera: {
    flex: 1,
  },
  overlay: {
    flex: 1,
    backgroundColor: 'transparent',
    justifyContent: 'center',
    alignItems: 'center',
  },
  scanText: {
    fontSize: 18,
    color: 'white',
    textAlign: 'center',
  },
});

export default QRCodeScanner;