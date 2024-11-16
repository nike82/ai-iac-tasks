FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y wget openjdk-11-jre-headless && \
    wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz && \
    tar -xzf apache-jmeter-5.6.3.tgz && \
    mv apache-jmeter-5.6.3 /opt/jmeter && \
    rm apache-jmeter-5.6.3.tgz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JMETER_HOME=/opt/jmeter
ENV PATH="${JMETER_HOME}/bin:${PATH}"

ENV PYTHONUNBUFFERED=1 \
    APP_HOME=/app

WORKDIR $APP_HOME

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["python", "app.py"]