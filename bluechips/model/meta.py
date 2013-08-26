"""SQLAlchemy Metadata and Session object"""
from sqlalchemy import MetaData
from sqlalchemy.orm import scoped_session, sessionmaker

# SQLAlchemy database engine.  Updated by model.init_model()
engine = None

# SQLAlchemy session manager.  Updated by model.init_model()
Session = None

from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

# Global metadata. If you have multiple databases with overlapping table
# names, you'll need a metadata for each database
metadata = Base.metadata

__all__ = ['engine', 'Session', 'metadata']
