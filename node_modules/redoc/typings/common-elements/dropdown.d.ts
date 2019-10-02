import Dropdown from 'react-dropdown';
export interface DropdownOption {
    label: string;
    value: string;
}
export interface DropdownProps {
    options: DropdownOption[];
    value: DropdownOption;
    onChange: (val: DropdownOption) => void;
}
export declare const StyledDropdown: import("styled-components").StyledComponent<typeof Dropdown, import("../theme").ResolvedThemeInterface, {}, never>;
export declare const SimpleDropdown: import("styled-components").StyledComponent<typeof Dropdown, import("../theme").ResolvedThemeInterface, {}, never>;
export declare const MimeLabel: import("styled-components").StyledComponent<"span", import("../theme").ResolvedThemeInterface, {}, never>;
