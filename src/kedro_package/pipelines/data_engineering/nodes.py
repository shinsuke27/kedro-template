import pandas as pd
import pandas_profiling as pdp


def exec_pdp(df: pd.DataFrame) -> str:
    return pdp.ProfileReport(df).to_html()
