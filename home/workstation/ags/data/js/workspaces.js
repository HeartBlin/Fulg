const hyprland = await Service.import('hyprland')

const symbols = [
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
    "七",
    "八",
    "九",
    "十",
];

function Workspaces() {
    const workspaces = hyprland.bind('workspaces');
    const activeId = hyprland.active.workspace.bind('id');
    return Widget.Box({
        class_name: 'workspaces',
        children: workspaces.as(ws => ws.map(({ id }) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${symbols[id-1]}`),
            class_name: activeId.as(i => `${i === id ? 'focused' : ''}`),
        }))),
    });
}

export default Workspaces;
