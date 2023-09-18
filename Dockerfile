FROM python:3.10-slim as base

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

WORKDIR /app



FROM base as builder

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.6

RUN apt-get update --fix-missing && apt-get install -y --fix-missing build-essential

RUN pip install "poetry==$POETRY_VERSION"

COPY pyproject.toml ./
COPY README.md ./

COPY chroma_crash ./chroma_crash
RUN poetry config virtualenvs.in-project true && \
    poetry install --only=main --no-root && \
    poetry build



FROM base as final

COPY --from=builder /app/.venv ./.venv
COPY --from=builder /app/dist .
COPY docker-entrypoint.sh .
RUN ./.venv/bin/pip install *.whl
RUN ["chmod", "+x", "docker-entrypoint.sh"]

CMD ["./docker-entrypoint.sh"]
