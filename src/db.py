from sqlalchemy import create_engine


def get_engine(connection_string: str):
    """Create a SQLAlchemy engine for the project database."""
    return create_engine(connection_string)
