import subprocess
from datetime import datetime
from time import sleep
import locale


def medir_velocidad_internet():
    comando = 'speedtest-cli --simple'
    resultado = subprocess.Popen(comando, shell=True, stdout=subprocess.PIPE).stdout.read().decode('utf-8')
    return resultado


def guardar_resultados(resultados):
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    velocidad_descarga = ""
    velocidad_subida = ""

    for linea in resultados.split("\n"):
        if "Ping" in linea:
            continue
        elif "Download" in linea:
            velocidad_descarga = linea.replace("Download:", "").strip()
        elif "Upload" in linea:
            velocidad_subida = linea.replace("Upload:", "").strip()

    with open('resultados.txt', 'a') as archivo:
        archivo.write('{:<19} | Download: {:<13} | Upload: {}\n'
                      .format(timestamp, velocidad_descarga, velocidad_subida))

    if velocidad_descarga:
        print('{:<19} | Download: {:<13} | Upload: {}'.format(timestamp, velocidad_descarga, velocidad_subida))
    else:
        print('{} | Error: Timed Out'.format(timestamp))
        reintento = medir_velocidad_internet()
        guardar_resultados(reintento)
        sleep(10)


def main():
    # Establecer el idioma en español
    locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')

    # Mensaje al inicio de la ejecución
    print("Medición cada 5 minutos de velocidad de internet")

    # Fecha y hora de las mediciones
    fecha_medicion = datetime.now().strftime('%d de %B del %Y desde las %H:%M')

    # Guardar mensaje en el archivo resultados.txt
    with open('resultados.txt', 'a') as archivo:
        archivo.write("\nMediciones del {}\n".format(fecha_medicion))

    while True:
        resultados = medir_velocidad_internet()
        guardar_resultados(resultados)
        sleep(300)  # Espera 5 minutos (300 segundos) antes de realizar la siguiente medición


if __name__ == '__main__':
    main()
