import React, { useState, useEffect } from 'react';
import { Text, View, StyleSheet, Alert, TouchableOpacity } from 'react-native';
import { BarCodeScanner } from 'expo-barcode-scanner';
import { useIsFocused } from '@react-navigation/native';

export default function App() {
  const [hasPermission, setHasPermission] = useState(null);
  const [scanned, setScanned] = useState(false);

  console.log(hasPermission, scanned);
  const isFocused = useIsFocused();

  useEffect(() => {
    (async () => {
      setScanned(false);
      const { status } = await BarCodeScanner.requestPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  const handleBarCodeScanned = ({ data }) => {
    setScanned(true);
    Alert.alert("Scanned Data", data);
  };

  if (hasPermission === null) {
    return <Text>Requesting for camera permission</Text>;
  }
  if (hasPermission === false) {
    return <Text>No access to camera</Text>;
  }

  return (
    <View style={styles.container}>

      <View style={styles.header}>
        <Text style={styles.headerTitle}>QR Scanner</Text>
      </View>

      {isFocused ? (
        <BarCodeScanner
          onBarCodeScanned={scanned ? undefined : handleBarCodeScanned}
          style={StyleSheet.absoluteFillObject}
        />
      ) : null}

      {scanned && (
        <TouchableOpacity style={styles.button} onPress={() => setScanned(false)}>
        <Text style={styles.buttonText}>Tap to Scan</Text>
      </TouchableOpacity>
      )}

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    backgroundColor: '#2196F3', 
    paddingTop: 40,
    paddingBottom: 16,
    alignItems: 'center', 
  },
  headerTitle: {
    color: 'white',
    fontSize: 20,
  },
  button: {
    position: 'absolute',
    bottom: 30,
    backgroundColor: '#2196F3',
    padding: 6,
    borderRadius: 30,
    alignItems: 'center',
    marginTop: 16,
    width: '40%',
    alignSelf: 'center',
    marginBottom: 16,
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
  },
});
