from kedro.pipeline import node, Pipeline
from kedro_package.pipelines.data_engineering.nodes import (
    exec_pdp
)


def create_pipeline(**kwargs):
    return Pipeline(
        [
            node(
                func=exec_pdp,
                inputs='train',
                outputs='train_pdp',
            ),
        ]
    )
