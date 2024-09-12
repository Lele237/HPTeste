import requests
import csv
from datetime import datetime, timedelta

# Chave de API da NASA
API_KEY = 'FyyoP56Ecjbj3EObhaAwxd8zIhK7ffjK8Hbrzdsk'
BASE_URL = 'https://api.nasa.gov/planetary/apod'

# Função para obter dados da API
def get_nasa_data(start_date, end_date):
    data = []
    current_date = start_date
    while current_date <= end_date:
        try:
            print(f"Obtendo dados para {current_date.strftime('%Y-%m-%d')}...")
            response = requests.get(BASE_URL, params={
                'api_key': API_KEY,
                'date': current_date.strftime('%Y-%m-%d')
            }, timeout=10)  # Adiciona um timeout de 10 segundos
            response.raise_for_status()  # Verifica se houve erro na requisição
            json_response = response.json()
            print(f"Data: {json_response['date']} - Status: OK")  # Mensagem de depuração
            data.append(json_response)
        except requests.exceptions.RequestException as e:
            print(f"Erro ao obter dados para {current_date.strftime('%Y-%m-%d')}: {e}")
        current_date += timedelta(days=1)
    return data

# Definindo o intervalo de datas (uma semana)
end_date = datetime.now()
start_date = end_date - timedelta(days=6)

# Obtendo os dados da NASA
print("Iniciando a coleta de dados...")
nasa_data = get_nasa_data(start_date, end_date)

# Verifique se há dados para salvar
if not nasa_data:
    print("Nenhum dado disponível para salvar.")
else:
    # Salve os dados em um arquivo CSV
    with open('nasa_data_week.csv', 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        # Escreva o cabeçalho
        writer.writerow(['date', 'title', 'url', 'explanation'])
        for item in nasa_data:
            writer.writerow([item['date'], item['title'], item['url'], item['explanation']])
    print('Dados salvos em nasa_data_week.csv')
