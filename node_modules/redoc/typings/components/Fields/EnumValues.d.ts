import * as React from 'react';
export interface EnumValuesProps {
    values: string[];
    type: string;
}
export declare class EnumValues extends React.PureComponent<EnumValuesProps> {
    static contextType: React.Context<import("../..").RedocNormalizedOptions>;
    render(): JSX.Element | null;
}
